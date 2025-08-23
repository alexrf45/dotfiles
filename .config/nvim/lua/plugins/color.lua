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

-- return {
--   "RRethy/base16-nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
--   end,
-- }

return {
  "rmehri01/onenord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("onenord")
  end,
}
