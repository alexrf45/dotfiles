return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
    -- Override background to pure black
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
  end,
}
