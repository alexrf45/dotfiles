return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-terracotta-dark")
    --
  end,
}
-- return {
--   "xeind/nightingale.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("nightingale").setup({
--       transparent = true, -- set to true for transparent background
--     })
--     vim.cmd("colorscheme nightingale")
--   end,
-- }
