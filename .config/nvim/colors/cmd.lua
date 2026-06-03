-- cmd.lua — classic Windows command prompt: plain white on pure black.
-- Aesthetic: restrained, near-monochrome. White text on a black void with
-- the canonical Windows console palette used sparingly for syntax so it
-- stays readable without being loud.
-- Mirrors the structure of colors/matrix.lua / colors/kali.lua so the
-- schemes stay swappable.
vim.opt.termguicolors = true
vim.cmd("highlight clear")
vim.g.colors_name = "cmd"

local c = {
  bg = "#000000", -- pure black void
  fg = "#C0C0C0", -- light gray — classic console default fg
  -- ANSI normal 0-7 (Windows console dark set)
  black = "#000000",
  red = "#CC0000", -- vivid red — errors / prompt accent (matches terminal)
  green = "#8A9A5B", -- dark green — strings
  yellow = "#808000", -- dark yellow / olive — numbers
  blue = "#000080", -- navy
  magenta = "#800080", -- dark magenta
  cyan = "#E5E4E2", -- teal — constants
  white = "#C0C0C0", -- light gray — console default fg
  -- ANSI bright 8-15
  brblack = "#808080", -- gray — comments / line numbers
  brred = "#FF0000", -- bright red
  brgreen = "#8A9A5B", -- bright green — keywords
  bryellow = "#FFFF00", -- bright yellow
  brblue = "#0000FF", -- bright blue
  brmagenta = "#FF00FF", -- bright magenta
  brcyan = "#E5E4E2", -- bright cyan — functions / types
  brwhite = "#FFFFFF", -- pure white — highlights
  -- UI extras
  gray = "#808080", -- comments / line numbers
  sel = "#264F78", -- console-style selection blue
  panel = "#0A0A0A", -- floats / menus, a hair above the void
}

local function hi(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

-- Editor UI
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.panel })
hi("FloatBorder", { fg = c.gray, bg = c.panel })
hi("LineNr", { fg = c.gray })
hi("CursorLineNr", { fg = c.brwhite, bold = true })
hi("CursorLine", { bg = c.panel })
hi("Visual", { bg = c.sel })
hi("Search", { fg = c.bg, bg = c.bryellow })
hi("IncSearch", { fg = c.bg, bg = c.brwhite })
hi("Pmenu", { fg = c.fg, bg = c.panel })
hi("PmenuSel", { fg = c.bg, bg = c.white })
hi("StatusLine", { fg = c.fg, bg = c.panel })
hi("Directory", { fg = c.white, bold = true }) -- folders in oil/netrw/pickers — bold light gray
hi("OilDir", { fg = c.white, bold = true })
hi("VertSplit", { fg = c.gray })
hi("WinSeparator", { fg = c.gray })
hi("ColorColumn", { bg = c.panel })
hi("Cursor", { fg = c.bg, bg = c.brwhite })

-- Syntax — mostly white, accents kept low-key
hi("Comment", { fg = c.gray, italic = true })
hi("Constant", { fg = c.brcyan })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.yellow })
hi("Boolean", { fg = c.yellow })
hi("Function", { fg = c.brcyan })
hi("Identifier", { fg = c.fg })
hi("Keyword", { fg = c.brwhite, bold = true })
hi("Statement", { fg = c.brwhite })
hi("Conditional", { fg = c.brwhite })
hi("Repeat", { fg = c.brwhite })
hi("Operator", { fg = c.white })
hi("Type", { fg = c.brcyan })
hi("PreProc", { fg = c.yellow })
hi("Special", { fg = c.brcyan })
hi("Error", { fg = c.brred })
hi("Todo", { fg = c.bg, bg = c.bryellow, bold = true })

-- Diagnostics
hi("DiagnosticError", { fg = c.brred })
hi("DiagnosticWarn", { fg = c.bryellow })
hi("DiagnosticInfo", { fg = c.brcyan })
hi("DiagnosticHint", { fg = c.white })

-- Diff / git
hi("DiffAdd", { fg = c.green })
hi("DiffChange", { fg = c.yellow })
hi("DiffDelete", { fg = c.brred })

-- Treesitter
hi("@variable", { fg = c.fg })
hi("@function", { fg = c.brcyan })
hi("@function.builtin", { fg = c.brcyan })
hi("@keyword", { fg = c.brwhite, bold = true })
hi("@string", { fg = c.green })
hi("@number", { fg = c.yellow })
hi("@boolean", { fg = c.yellow })
hi("@type", { fg = c.brcyan })
hi("@constant", { fg = c.brcyan })
hi("@comment", { fg = c.gray, italic = true })
hi("@punctuation", { fg = c.white })
hi("@operator", { fg = c.white })
