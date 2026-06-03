-- matrix.lua — "The Matrix" phosphor-green Neovim colorscheme.
-- Aesthetic: green + amber accents on a pure-black void.
--   greens  → the digital-rain spectrum (dim phosphor → bright rain)
--   amber   → numbers, warnings, errors (old-CRT nod + readability)
-- Mirrors the structure of colors/kali.lua so the two stay swappable.
vim.opt.termguicolors = true
vim.cmd("highlight clear")
vim.g.colors_name = "matrix"

local c = {
  bg = "#000000", -- pure black void
  fg = "#00D92B", -- primary phosphor green
  -- ANSI normal 0-7
  black = "#0D0208", -- canonical Matrix near-black (panels just above the void)
  red = "#FF4F00", -- amber-red — errors
  green = "#008F11", -- classic Matrix green — strings
  yellow = "#FFB000", -- amber — numbers / warnings
  blue = "#00B86B", -- cool green — functions
  magenta = "#6FFF9F", -- pale green
  cyan = "#39FF74", -- bright mint — constants
  white = "#00C730", -- mid green
  -- ANSI bright 8-15
  brblack = "#005F1E", -- dim phosphor — comments / line numbers
  brred = "#FF6B33", -- bright amber-red
  brgreen = "#00FF41", -- the iconic digital-rain green — keywords
  bryellow = "#FFC957", -- bright amber
  brblue = "#2BE08A", -- mint — builtin functions
  brmagenta = "#9FFFC4", -- pale mint
  brcyan = "#6FFF9F", -- pale green
  brwhite = "#C8FFD4", -- pale green-white — highlights
  -- UI extras
  gray = "#005F1E", -- ForegroundInactive — comments / line numbers (dim phosphor)
  sel = "#003B00", -- dark phosphor — selection background
  panel = "#0A0E0A", -- floats / menus, a hair above the void
}

local function hi(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

-- Editor UI
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.panel })
hi("FloatBorder", { fg = c.green, bg = c.panel })
hi("LineNr", { fg = c.gray })
hi("CursorLineNr", { fg = c.brgreen, bold = true })
hi("CursorLine", { bg = c.panel })
hi("Visual", { bg = c.sel })
hi("Search", { fg = c.bg, bg = c.yellow })
hi("IncSearch", { fg = c.bg, bg = c.brgreen })
hi("Pmenu", { fg = c.fg, bg = c.panel })
hi("PmenuSel", { fg = c.bg, bg = c.green })
hi("StatusLine", { fg = c.fg, bg = c.panel })
hi("VertSplit", { fg = c.gray })
hi("WinSeparator", { fg = c.gray })
hi("ColorColumn", { bg = c.panel })
hi("Cursor", { fg = c.bg, bg = c.brgreen })

-- Syntax
hi("Comment", { fg = c.gray, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.yellow })
hi("Boolean", { fg = c.yellow })
hi("Function", { fg = c.blue })
hi("Identifier", { fg = c.fg })
hi("Keyword", { fg = c.brgreen, bold = true })
hi("Statement", { fg = c.brgreen })
hi("Conditional", { fg = c.brgreen })
hi("Repeat", { fg = c.brgreen })
hi("Operator", { fg = c.white })
hi("Type", { fg = c.brblue })
hi("PreProc", { fg = c.bryellow })
hi("Special", { fg = c.cyan })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.bg, bg = c.yellow, bold = true })

-- Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.brblue })
hi("DiagnosticHint", { fg = c.cyan })

-- Diff / git
hi("DiffAdd", { fg = c.green })
hi("DiffChange", { fg = c.yellow })
hi("DiffDelete", { fg = c.red })

-- Treesitter
hi("@variable", { fg = c.fg })
hi("@function", { fg = c.blue })
hi("@function.builtin", { fg = c.brblue })
hi("@keyword", { fg = c.brgreen, bold = true })
hi("@string", { fg = c.green })
hi("@number", { fg = c.yellow })
hi("@boolean", { fg = c.yellow })
hi("@type", { fg = c.brblue })
hi("@constant", { fg = c.cyan })
hi("@comment", { fg = c.gray, italic = true })
hi("@punctuation", { fg = c.gray })
hi("@operator", { fg = c.white })
