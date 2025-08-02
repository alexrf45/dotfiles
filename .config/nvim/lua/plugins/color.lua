-- return {
--   "loctvl842/monokai-pro.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("monokai-pro").setup({
--       transparent_background = true,
--     })
--     vim.cmd("colorscheme monokai-pro-spectrum")
--   end,
-- }

return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-irblack")
    -- require("base16-colorscheme").setup({
    --   base00 = "#0d0d0d", -- Very Dark Background
    --   base01 = "#121212", -- Darker Background
    --   base02 = "#00FF00", -- Selection Background
    --   base03 = "#ffffff", -- Dimmed Foreground (Comments)
    --   base04 = "#2e2e2e", -- Dark Foreground
    --   base05 = "#ffffff", -- Hacker Green Foreground (Main Text)
    --   base06 = "#ffffff", -- Hacker Green Foreground (Lighter Text)
    --   base07 = "#ffffff", -- Hacker Green Foreground (Brightest Text)
    --   base08 = "#FF0000", -- Hacker Green (Variables, Constants)
    --   base09 = "#ffffff", -- Hacker Green (Keywords)
    --   base0A = "#ffffff", -- Hacker Green (Types, Classes)
    --   base0B = "#ffffff", -- Hacker Green (Functions, Identifiers)
    --   base0C = "#ffffff", -- Hacker Green (Attributes, Special)
    --   base0D = "#00FF00", -- Hacker Green (Titles, Headings)
    --   base0E = "#ffffff", -- Hacker Green (Additional Accents)
    --   base0F = "#ffffff", -- Hacker Green (Rare, Important Elements)
    -- })
  end,
}
