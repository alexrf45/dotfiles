return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-default-dark")
    require("base16-colorscheme").setup({
      base00 = "#000000", -- Default background (primary background)
      base01 = "#383838", -- Lighter background (selection background)
      base02 = "#585858", -- Selection background (bright black)
      base03 = "#585858", -- Comments, line numbers (bright black)
      base04 = "#d8d8d8", -- Dark foreground (normal white)
      base05 = "#ddc7a1", -- Default foreground (primary foreground)
      base06 = "#f8f8f8", -- Light foreground (bright white)
      base07 = "#f8f8f8", -- Light background (bright white)
      base08 = "#ab4642", -- Red (variables, errors)
      base09 = "#f7ca88", -- Orange (integers, constants) → yellow as closest warm
      base0A = "#f7ca88", -- Yellow (classes, search)
      base0B = "#a1b56c", -- Green (strings)
      base0C = "#86c1b9", -- Cyan (regex, support)
      base0D = "#7cafc2", -- Blue (functions, methods)
      base0E = "#ba8baf", -- Magenta (keywords)
      base0F = "#ab4642", -- Brown (deprecated) → red as closest dark warm
    })
  end,
}
