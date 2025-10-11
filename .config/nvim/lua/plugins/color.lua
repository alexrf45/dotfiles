return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-bright")
    require("base16-colorscheme").setup({
      base00 = "#000000", -- Default background (Tango black)
      base01 = "#555753", -- Lighter background (Tango bright black)
      base02 = "#555753", -- Selection background
      base03 = "#888a85", -- Comments, line numbers
      base04 = "#babdb6", -- Dark foreground
      base05 = "#d3d7cf", -- Default foreground (Tango white)
      base06 = "#eeeeec", -- Light foreground (Tango bright white)
      base07 = "#eeeeec", -- Light background
      base08 = "#ef2929", -- Red (variables, errors)
      base09 = "#fcaf3e", -- Orange (integers, constants)
      base0A = "#fce94f", -- Yellow (classes, search)
      base0B = "#8ae234", -- Green (strings)
      base0C = "#34e2e2", -- Cyan (regex, support)
      base0D = "#729fcf", -- Blue (functions, methods)
      base0E = "#ad7fa8", -- Magenta (keywords)
      base0F = "#c4a000", -- Brown (deprecated)
    })
  end,
}
