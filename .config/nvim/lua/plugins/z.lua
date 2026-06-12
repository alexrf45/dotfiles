return {
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-telekasten/calendar-vim" },
  config = function()
    -- Escape % so titles like "100% uptime" are safe in gsub replacements.
    local function esc(s)
      return (s:gsub("%%", "%%%%"))
    end

    -- Turn a human title into a filename slug: lowercase, non-alphanumeric runs
    -- collapsed to a single hyphen, trimmed, capped at ~50 chars on a word
    -- boundary. Used so notes are named `{uuid}-{slug}.md` for legibility.
    local function slugify(title)
      local s = title:lower():gsub("[^a-z0-9]+", "-"):gsub("^%-+", ""):gsub("%-+$", "")
      if #s > 50 then
        s = s:sub(1, 50):gsub("%-[^%-]*$", "")
      end
      return s
    end

    -- Create a timestamped note from a template.
    -- opts: { label, dir, template, tag? }
    -- When `tag` is set, the template's tag line is rewritten to that FLAP tag
    -- (note.md's `- fleeting` or moc.md's inline `tags: []`) and any empty
    -- `title:`/`uuid:`/`date:` frontmatter fields are filled in.
    local function new_note(opts)
      local title = vim.fn.input(opts.label .. " title: ")
      if title == "" then
        return
      end
      local uuid = os.date("%Y%m%d%H%M")
      local rfc3339 = os.date("%Y-%m-%dT%H:%M:%SZ")
      local dir = vim.fn.expand(opts.dir)
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
      end
      local slug = slugify(title)
      local base = slug ~= "" and (uuid .. "-" .. slug) or uuid
      local path = dir .. base .. ".md"
      local template = io.open(vim.fn.expand(opts.template), "r")
      local content = template:read("*a")
      template:close()
      content = content:gsub("{{title}}", esc(title))
      content = content:gsub("{{uuid}}", uuid)
      content = content:gsub("{{rfc3339}}", rfc3339)
      if opts.tag then
        content = content:gsub("\ntitle: %[%]", "\ntitle: " .. esc(title))
        content = content:gsub("\nuuid: %[%]", "\nuuid: " .. uuid)
        content = content:gsub("\ndate: %[%]", "\ndate: " .. rfc3339)
        content = content:gsub("\n  %- fleeting", "\n  - " .. opts.tag) -- note.md (multi-line tags)
        content = content:gsub("\ntags: %[%]", "\ntags: [" .. opts.tag .. "]") -- moc.md (inline tags)
      end
      local out = io.open(path, "w")
      out:write(content)
      out:close()
      vim.cmd("edit " .. path)
    end

    require("telekasten").setup({
      command_palette_theme = "dropdown",
      show_tags_theme = "dropdown",
      tag_notation = "yaml-bare",
      home = vim.fn.expand("~/fr3d"),
      templates = vim.fn.expand("~/fr3d/templates"),
      template_new_note = vim.fn.expand("~/fr3d/templates/note.md"),
      dailies = vim.fn.expand("~/fr3d/daily"),
      template_new_daily = vim.fn.expand("~/fr3d/templates/daily.md"),
      image_subdir = vim.fn.expand("~/fr3d/media/images"),
      vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>"),
      vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>"),
      vim.keymap.set("n", "<leader>zs", "<cmd>Telekasten search_notes<CR>"),
      vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>"),
      -- Fleeting capture lands in inbox/ — one place to process from.
      vim.keymap.set("n", "<leader>zn", function()
        new_note({
          label = "Fleeting note",
          dir = "~/fr3d/inbox/",
          template = "~/fr3d/templates/note.md",
          tag = "fleeting",
        })
      end, { desc = "New fleeting note (inbox)" }),
      -- Permanent typed notes at vault root, tagged by FLAP lifecycle state.
      vim.keymap.set("n", "<leader>zNa", function()
        new_note({
          label = "Atomic note",
          dir = "~/fr3d/",
          template = "~/fr3d/templates/note.md",
          tag = "atomic",
        })
      end, { desc = "New atomic note" }),
      vim.keymap.set("n", "<leader>zNl", function()
        new_note({
          label = "Literature note",
          dir = "~/fr3d/",
          template = "~/fr3d/templates/note.md",
          tag = "literature",
        })
      end, { desc = "New literature note" }),
      vim.keymap.set("n", "<leader>zNp", function()
        new_note({
          label = "Project MOC",
          dir = "~/fr3d/",
          template = "~/fr3d/templates/moc.md",
          tag = "project",
        })
      end, { desc = "New project MOC" }),
      vim.keymap.set("n", "<leader>za", "<cmd>Telekasten new_templated_note<CR>"),
      vim.keymap.set("n", "<leader>zp", function()
        new_note({
          label = "Poem",
          dir = "~/fr3d/writing/",
          template = "~/fr3d/templates/poem.md",
        })
      end, { desc = "New poem note" }),
      -- Daily note in daily/YYYY-MM-DD.md (3 tasks + a Log) from templates/daily.md.
      vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "Daily note (today)" }),
      vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>"),
      vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>"),
      vim.keymap.set("n", "<leader>zt", function()
        local vault = vim.fn.expand("~/fr3d")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local themes = require("telescope.themes")
        local make_entry = require("telescope.make_entry")

        local tag_files = {}

        -- Pass 1: inline  tags: [tag1, tag2]
        local inline = vim.fn.systemlist(
          "rg --with-filename -o 'tags: \\[[^\\]]+\\]' '"
            .. vault
            .. "'"
            .. " '--glob=*.md' '--glob=!templates/*.md' 2>/dev/null"
        )
        for _, line in ipairs(inline) do
          local path, inner = line:match("^(.-):tags: %[(.-)%]$")
          if inner then
            for tag in inner:gmatch("[^,]+") do
              tag = tag:match("^%s*(.-)%s*$")
              if tag ~= "" then
                if not tag_files[tag] then
                  tag_files[tag] = {}
                end
                tag_files[tag][path] = true
              end
            end
          end
        end

        -- Pass 2: multi-line list items in frontmatter (line ≤ 15)
        --   tags:
        --     - tagname
        local multiline = vim.fn.systemlist(
          "rg --vimgrep '^\\s+- [a-zA-Z0-9_/-]+$' '"
            .. vault
            .. "'"
            .. " '--glob=*.md' '--glob=!templates/*.md' 2>/dev/null"
        )
        for _, line in ipairs(multiline) do
          local path, lnum, tag = line:match("^(.-):(%d+):%d+:%s+%-%s+(.-)%s*$")
          if path and tag ~= "" and tonumber(lnum) <= 15 then
            if not tag_files[tag] then
              tag_files[tag] = {}
            end
            tag_files[tag][path] = true
          end
        end

        -- Build sorted taglist
        local taglist = {}
        for tag, paths in pairs(tag_files) do
          local files = vim.tbl_keys(paths)
          taglist[#taglist + 1] = { tag = tag, files = files }
        end
        table.sort(taglist, function(a, b)
          return a.tag < b.tag
        end)

        if #taglist == 0 then
          vim.notify("No tags found in vault", vim.log.levels.WARN)
          return
        end

        local max_len = 0
        for _, e in ipairs(taglist) do
          if #e.tag > max_len then
            max_len = #e.tag
          end
        end

        pickers
          .new(
            themes.get_dropdown({
              layout_config = {
                prompt_position = "top",
                height = math.min(math.floor(vim.o.lines * 0.8), #taglist + 4),
              },
            }),
            {
              prompt_title = "Tags",
              finder = finders.new_table({
                results = taglist,
                entry_maker = function(e)
                  return {
                    value = e,
                    display = string.format("%-" .. max_len .. "s  (%d notes)", e.tag, #e.files),
                    ordinal = e.tag,
                  }
                end,
              }),
              sorter = conf.generic_sorter({}),
              attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                  local sel = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  if not sel then
                    return
                  end
                  pickers
                    .new({}, {
                      prompt_title = "Tagged: #" .. sel.value.tag,
                      finder = finders.new_table({
                        results = sel.value.files,
                        entry_maker = make_entry.gen_from_file({ cwd = vault }),
                      }),
                      sorter = conf.generic_sorter({}),
                      previewer = conf.file_previewer({ cwd = vault }),
                    })
                    :find()
                end)
                return true
              end,
            }
          )
          :find()
      end, { desc = "Show tags" }),
      vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>"),
      vim.keymap.set("n", "<leader>zl", "<cmd>Telekasten insert_link<CR>"),
    })
  end,
}
