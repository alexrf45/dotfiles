return {
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-telekasten/calendar-vim" },
  config = function()
    require("telekasten").setup({
      journal_auto_open = true,
      command_palette_theme = "dropdown",
      show_tags_theme = "dropdown",
      tag_notation = "yaml-bare",
      home = vim.fn.expand("~/fr3d"),
      dailies = vim.fn.expand("~/fr3d/daily"),
      weeklies = vim.fn.expand("~/fr3d/weekly"),
      templates = vim.fn.expand("~/fr3d/templates"),
      template_new_note = vim.fn.expand("~/fr3d/templates/note.md"),
      template_new_daily = vim.fn.expand("~/fr3d/templates/daily.md"),
      template_new_weekly = vim.fn.expand("~/fr3d/templates/weekly.md"),
      image_subdir = vim.fn.expand("~/fr3d/media/images"),
      vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>"),
      vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>"),
      vim.keymap.set("n", "<leader>zs", "<cmd>Telekasten search_notes<CR>"),
      vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>"),
      vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>"),
      vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>"),
      vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>"),
      vim.keymap.set("n", "<leader>za", "<cmd>Telekasten new_templated_note<CR>"),
      vim.keymap.set("n", "<leader>zp", function()
        local uuid = os.date("%Y%m%d%H%M")
        local path = vim.fn.expand("~/fr3d/inbox/") .. uuid .. ".md"
        local rfc3339 = os.date("%Y-%m-%dT%H:%M:%SZ")
        local template = io.open(vim.fn.expand("~/fr3d/templates/poem.md"), "r")
        local content = template:read("*a")
        template:close()
        content = content:gsub("{{rfc3339}}", rfc3339)
        content = content:gsub("{{uuid}}", uuid)
        local out = io.open(path, "w")
        out:write(content)
        out:close()
        vim.cmd("edit " .. path)
      end, { desc = "New poem note in inbox" }),
      vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>"),
      vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>"),
      vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten show_tags<CR>"),
      vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>"),
      vim.keymap.set("n", "<leader>zl", "<cmd>Telekasten insert_link<CR>"),
    })
  end,
}
