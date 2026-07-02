return {
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-telekasten/calendar-vim" },
  config = function()
    local vault = vim.fn.expand("~/fr3d")

    -- Escape % so titles like "100% uptime" are safe in gsub replacements.
    local function esc(s)
      return (s:gsub("%%", "%%%%"))
    end

    -- Create a timestamped note from a template.
    -- opts: { label, dir, template }
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
      local path = dir .. uuid .. ".md"
      local template = io.open(vim.fn.expand(opts.template), "r")
      local content = template:read("*a")
      template:close()
      content = content:gsub("{{title}}", esc(title))
      content = content:gsub("{{uuid}}", uuid)
      content = content:gsub("{{rfc3339}}", rfc3339)
      local out = io.open(path, "w")
      out:write(content)
      out:close()
      vim.cmd("edit " .. path)
    end

    -- ── follow wikilink ────────────────────────────────────────────────────

    -- Extract the [[link]] stem under the cursor (strips aliases and #headings).
    local function link_under_cursor()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2] + 1
      local before = line:sub(1, col)
      local s = before:find("%[%[[^%[]*$")
      if not s then return nil end
      local rest = line:sub(s + 2)
      local e = rest:find("%]%]")
      if not e then return nil end
      local link = rest:sub(1, e - 1)
      link = link:gsub("|.*", ""):gsub("#.*", ""):match("^%s*(.-)%s*$")
      return link ~= "" and link or nil
    end

    -- Follow a [[wikilink]] without Telescope. Opens the file directly when
    -- there is exactly one match; falls back to fzf when ambiguous.
    local function follow_link()
      local link = link_under_cursor()
      if not link then
        vim.notify("No wikilink under cursor", vim.log.levels.WARN)
        return
      end
      -- Match exact stem (link.md) OR uuid-prefixed slug (link-*.md).
      -- Using fd for speed; falls back to find.
      local cmd = "fd --type f --full-path --glob '*/" .. link .. "*.md' "
        .. vim.fn.shellescape(vault)
        .. " --exclude templates 2>/dev/null"
      local matches = vim.fn.systemlist(cmd)
      -- Filter to only files whose stem starts with the link exactly.
      local stem_matches = vim.tbl_filter(function(p)
        local stem = p:match("([^/]+)%.md$") or ""
        return stem == link or stem:sub(1, #link + 1) == link .. "-"
      end, matches)
      if #stem_matches == 1 then
        vim.cmd("edit " .. vim.fn.fnameescape(stem_matches[1]))
      elseif #stem_matches > 1 then
        require("fzf-lua").fzf_exec(stem_matches, {
          prompt = "[[" .. link .. "]] > ",
          actions = { ["default"] = require("fzf-lua.actions").file_edit },
          previewer = "builtin",
        })
      else
        vim.notify("No note found for [[" .. link .. "]]", vim.log.levels.WARN)
      end
    end

    -- ── fzf-lua vault pickers ──────────────────────────────────────────────

    -- Find notes by filename (fzf over all vault .md files).
    local function vault_files()
      require("fzf-lua").files({
        cwd = vault,
        fd_opts = "--type f --extension md --exclude templates",
        prompt = "Notes > ",
      })
    end

    -- Search note content with ripgrep + fzf.
    local function vault_grep()
      require("fzf-lua").live_grep({
        cwd = vault,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case "
          .. "--glob '*.md' --glob '!templates/*.md'",
        prompt = "Search > ",
      })
    end

    -- Two-level fzf tag picker: select a tag → see files tagged with it.
    local function vault_tags()
      local tag_files = {}

      -- Inline tags: [tag1, tag2]
      local inline = vim.fn.systemlist(
        "rg --with-filename -o 'tags: \\[[^\\]]+\\]' '"
          .. vault
          .. "' --glob='*.md' --glob='!templates/*.md' 2>/dev/null"
      )
      for _, line in ipairs(inline) do
        local path, inner = line:match("^(.-):tags: %[(.-)%]$")
        if inner then
          for tag in inner:gmatch("[^,]+") do
            tag = tag:match("^%s*(.-)%s*$")
            if tag ~= "" then
              tag_files[tag] = tag_files[tag] or {}
              tag_files[tag][path] = true
            end
          end
        end
      end

      -- Multi-line list tags (line ≤ 15 to stay in frontmatter)
      local multiline = vim.fn.systemlist(
        "rg --vimgrep '^\\s+- [a-zA-Z0-9_/-]+$' '"
          .. vault
          .. "' --glob='*.md' --glob='!templates/*.md' 2>/dev/null"
      )
      for _, line in ipairs(multiline) do
        local path, lnum, tag = line:match("^(.-):(%d+):%d+:%s+%-%s+(.-)%s*$")
        if path and tag ~= "" and tonumber(lnum) <= 15 then
          tag_files[tag] = tag_files[tag] or {}
          tag_files[tag][path] = true
        end
      end

      -- Build display list sorted by tag name.
      local entries = {}
      for tag, paths in pairs(tag_files) do
        local files = vim.tbl_keys(paths)
        entries[#entries + 1] = {
          display = string.format("%-30s (%d)", tag, #files),
          tag = tag,
          files = files,
        }
      end
      table.sort(entries, function(a, b) return a.tag < b.tag end)

      if #entries == 0 then
        vim.notify("No tags found in vault", vim.log.levels.WARN)
        return
      end

      local fzf = require("fzf-lua")
      fzf.fzf_exec(vim.tbl_map(function(e) return e.display end, entries), {
        prompt = "Tags > ",
        actions = {
          ["default"] = function(selected)
            if not selected or #selected == 0 then return end
            local label = selected[1]
            -- Find the entry that matches
            local chosen
            for _, e in ipairs(entries) do
              if e.display == label then
                chosen = e
                break
              end
            end
            if not chosen then return end
            fzf.fzf_exec(chosen.files, {
              prompt = "#" .. chosen.tag .. " > ",
              actions = { ["default"] = require("fzf-lua.actions").file_edit },
              previewer = "builtin",
            })
          end,
        },
      })
    end

    -- ── Telekasten core setup ──────────────────────────────────────────────

    require("telekasten").setup({
      command_palette_theme = "dropdown",
      show_tags_theme = "dropdown",
      tag_notation = "yaml-bare",
      home = vault,
      templates = vault .. "/templates",
      template_new_note = vault .. "/templates/note.md",
      dailies = vault .. "/daily",
      template_new_daily = vault .. "/templates/daily.md",
      image_subdir = vault .. "/media/images",
    })

    -- ── Keybindings ───────────────────────────────────────────────────────

    -- Panel / meta
    vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")
    vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")

    -- Navigation
    vim.keymap.set("n", "<leader>zz", follow_link, { desc = "Follow wikilink" })
    vim.keymap.set("n", "<leader>zl", "<cmd>Telekasten insert_link<CR>")
    vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
    vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

    -- Daily note
    vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "Daily note (today)" })

    -- ── FLAP note creation ───────────────────────────────────────────────
    -- zi  → fleeting  (inbox/ — quick capture, process later)
    -- zn  → atomic    (root  — single permanent idea)
    -- znl → literature (root — processed source material)
    -- znp → project   (root — active project / scoped MOC)
    -- zp  → poem      (writing/)

    vim.keymap.set("n", "<leader>zi", function()
      new_note({ label = "Fleeting", dir = vault .. "/inbox/", template = vault .. "/templates/note.md" })
    end, { desc = "New fleeting note (inbox)" })

    vim.keymap.set("n", "<leader>zn", function()
      new_note({ label = "Atomic", dir = vault .. "/", template = vault .. "/templates/atomic.md" })
    end, { desc = "New atomic note (root)" })

    vim.keymap.set("n", "<leader>znl", function()
      new_note({ label = "Literature", dir = vault .. "/", template = vault .. "/templates/literature.md" })
    end, { desc = "New literature note (root)" })

    vim.keymap.set("n", "<leader>znp", function()
      new_note({ label = "Project", dir = vault .. "/", template = vault .. "/templates/project.md" })
    end, { desc = "New project note (root)" })

    vim.keymap.set("n", "<leader>zp", function()
      new_note({ label = "Poem", dir = vault .. "/writing/", template = vault .. "/templates/poem.md" })
    end, { desc = "New poem (writing/)" })

    -- ── fzf-lua vault search ─────────────────────────────────────────────
    vim.keymap.set("n", "<leader>zf", vault_files, { desc = "Find note (fzf)" })
    vim.keymap.set("n", "<leader>zs", vault_grep, { desc = "Search notes (fzf)" })
    vim.keymap.set("n", "<leader>zt", vault_tags, { desc = "Tag picker (fzf)" })
  end,
}
