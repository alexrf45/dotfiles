-- return {
--   "sainnhe/gruvbox-material",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Optionally configure and load the colorscheme
--     -- directly inside the plugin declaration.
--     vim.g.gruvbox_material_enable_italic = true
--     vim.g.gruvbox_material_background = "soft"
--     vim.cmd.colorscheme("gruvbox-material")
--   end,
-- }
--
-- return {
--   "RRethy/base16-nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
--   end,
-- }

-- return {
--   "fcancelinha/nordern.nvim",
--   branch = "master",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("nordern")
--   end,
-- }

return {
  "armannikoyan/rusty",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    italic_comments = true,
    underline_current_line = true,
    colors = {
      foreground = "#c5c8c6",
      background = "#1d1f21",
      selection = "#373b41",
      line = "#282a2e",
      comment = "#969896",
      red = "#cc6666",
      orange = "#de935f",
      yellow = "#f0c674",
      green = "#b5bd68",
      aqua = "#8abeb7",
      blue = "#81a2be",
      purple = "#b294bb",
      window = "#4d5057",
    },
  },
  config = function(_, opts)
    require("rusty").setup(opts)
    vim.cmd("colorscheme rusty")
  end,
}
