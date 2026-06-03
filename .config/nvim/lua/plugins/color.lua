-- return {
--   "RRethy/base16-nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("base16-irblack")
--     --
--   end,
-- }
return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Active scheme: cmd (colors/cmd.lua) — white-on-black console look.
    -- Nordic stays installed as a fallback — switch back any time with
    -- :colorscheme nordic (or :colorscheme matrix for the green phosphor set)
    vim.cmd.colorscheme("cmd")
  end,
}
