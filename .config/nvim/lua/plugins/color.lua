return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}

-- return {
--   "xeind/nightingale.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("nightingale").setup({
--       transparent = false,
--       colors = {
--         theme = {
--           nightingale = {
--             ui = {
--               bg = "#32302f", -- gruvbox-material dark soft main bg
--               bg_dim = "#2a2827", -- slightly darker for dim areas
--               bg_gutter = "#32302f", -- gutter matches main bg
--               bg_m3 = "#282625",
--               bg_m2 = "#2c2a29",
--               bg_m1 = "#2f2d2c",
--               bg_p1 = "#3c3836", -- gruvbox dark1 - cursorline, selections
--               bg_p2 = "#504945", -- gruvbox dark2 - visual, deeper UI
--               float = {
--                 bg = "#2c2a29",
--                 bg_border = "#3c3836",
--               },
--               pmenu = {
--                 bg = "#2c2a29",
--                 bg_sel = "#3c3836",
--                 bg_sbar = "#32302f",
--                 bg_thumb = "#504945",
--               },
--             },
--           },
--         },
--       },
--       overrides = function(colors)
--         local theme = colors.theme
--         return {
--           -- Reinforce the lighter background on core groups
--           Normal = { bg = theme.ui.bg },
--           NormalNC = { bg = theme.ui.bg_dim },
--           NormalFloat = { bg = theme.ui.float.bg },
--           SignColumn = { bg = theme.ui.bg },
--           FoldColumn = { bg = theme.ui.bg },
--           CursorLine = { bg = theme.ui.bg_p1 },
--           CursorLineNr = { bg = theme.ui.bg_p1 },
--           ColorColumn = { bg = theme.ui.bg_p1 },
--           StatusLine = { bg = "#3c3836" },
--           StatusLineNC = { bg = "#32302f" },
--           WinSeparator = { fg = "#504945", bg = "NONE" },
--           TabLine = { bg = "#2c2a29" },
--           TabLineFill = { bg = "#2c2a29" },
--           TabLineSel = { bg = "#32302f" },
--         }
--       end,
--     })
--     vim.cmd("colorscheme nightingale")
--   end,
-- }
