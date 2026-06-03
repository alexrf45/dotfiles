-- kali.lua — Neovim colorscheme matching Kali Linux's default terminal palette.
-- Source of truth: kali-themes package (gitlab.com/kalilinux/packages/kali-themes)
--   ANSI 16  → share/xfce4/terminal/colorschemes/Kali.theme (ColorPalette)
--   bg/fg/UI → share/color-schemes/KaliDark.colors (konsole, RGB → hex below)
vim.opt.termguicolors = true
vim.cmd("highlight clear")
vim.g.colors_name = "kali"

local c = {
  bg = "#23252E", -- window background (35,37,46)
  fg = "#E6E6E6", -- ANSI white (color 7); konsole fg is #FFFFFF if you want it brighter
  -- ANSI normal 0-7
  black = "#1F2229",
  red = "#D41919",
  green = "#5EBDAB",
  yellow = "#FEA44C",
  blue = "#367BF0", -- Kali signature blue (color 4)
  magenta = "#9755B3",
  cyan = "#49AEE6",
  white = "#E6E6E6",
  -- ANSI bright 8-15 (note: Kali maps bright-black to teal, not a gray)
  brblack = "#198388",
  brred = "#EC0101",
  brgreen = "#47D4B9",
  bryellow = "#FF8A18",
  brblue = "#277FFF",
  brmagenta = "#962AC3",
  brcyan = "#05A1F7",
  brwhite = "#FFFFFF",
  -- UI extras from KaliDark.colors
  gray = "#5C626C", -- ForegroundInactive (92,98,108) — comments / line numbers
  sel = "#2777FF", -- Selection BackgroundNormal (39,119,255)
  panel = "#1F2229", -- slightly darker than bg for menus/floats
}

local function hi(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

-- Editor UI
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.panel })
hi("FloatBorder", { fg = c.gray, bg = c.panel })
hi("LineNr", { fg = c.gray })
hi("CursorLineNr", { fg = c.brblue, bold = true })
hi("CursorLine", { bg = c.panel })
hi("Visual", { bg = c.sel })
hi("Search", { fg = c.bg, bg = c.yellow })
hi("IncSearch", { fg = c.bg, bg = c.brblue })
hi("Pmenu", { fg = c.fg, bg = c.panel })
hi("PmenuSel", { fg = c.bg, bg = c.blue })
hi("StatusLine", { fg = c.fg, bg = c.panel })
hi("VertSplit", { fg = c.gray })
hi("WinSeparator", { fg = c.gray })
hi("ColorColumn", { bg = c.panel })

-- Syntax
hi("Comment", { fg = c.gray, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.bryellow })
hi("Boolean", { fg = c.bryellow })
hi("Function", { fg = c.blue })
hi("Identifier", { fg = c.fg })
hi("Keyword", { fg = c.brblue, bold = true })
hi("Statement", { fg = c.magenta })
hi("Conditional", { fg = c.magenta })
hi("Repeat", { fg = c.magenta })
hi("Operator", { fg = c.brcyan })
hi("Type", { fg = c.yellow })
hi("PreProc", { fg = c.brmagenta })
hi("Special", { fg = c.brcyan })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.bg, bg = c.yellow, bold = true })

-- Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.brblue })
hi("DiagnosticHint", { fg = c.brcyan })

-- Diff / git
hi("DiffAdd", { fg = c.green })
hi("DiffChange", { fg = c.yellow })
hi("DiffDelete", { fg = c.red })

-- Treesitter
hi("@variable", { fg = c.fg })
hi("@function", { fg = c.blue })
hi("@function.builtin", { fg = c.brblue })
hi("@keyword", { fg = c.brblue, bold = true })
hi("@string", { fg = c.green })
hi("@type", { fg = c.yellow })
hi("@constant", { fg = c.cyan })
hi("@comment", { fg = c.gray, italic = true })
hi("@punctuation", { fg = c.fg })
hi("@operator", { fg = c.brcyan })
