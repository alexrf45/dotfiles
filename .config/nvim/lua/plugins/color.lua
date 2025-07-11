return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-bright")
    require("base16-colorscheme").setup({
      base00 = "#0d0d0d", -- Very Dark Background
      base01 = "#121212", -- Darker Background
      base02 = "#1a1a1a", -- Selection Background
      base03 = "#ffffff", -- Dimmed Foreground (Comments)
      base04 = "#2e2e2e", -- Dark Foreground
      base05 = "#00ff00", -- Hacker Green Foreground (Main Text)
      base06 = "#00ff00", -- Hacker Green Foreground (Lighter Text)
      base07 = "#00ff00", -- Hacker Green Foreground (Brightest Text)
      base08 = "#00ff00", -- Hacker Green (Variables, Constants)
      base09 = "#00ff00", -- Hacker Green (Keywords)
      base0A = "#00ff00", -- Hacker Green (Types, Classes)
      base0B = "#00ff00", -- Hacker Green (Functions, Identifiers)
      base0C = "#00ff00", -- Hacker Green (Attributes, Special)
      base0D = "#00ff00", -- Hacker Green (Titles, Headings)
      base0E = "#00ff00", -- Hacker Green (Additional Accents)
      base0F = "#00ff00", -- Hacker Green (Rare, Important Elements)
    })
  end,
}
