vim.opt.termguicolors = true
vim.cmd("highlight clear")
vim.g.colors_name = "kali"

local c = {
  bg = "#1c2023",
  fg = "#c7ccd1",
  blue = "#367bf0",
  cyan = "#34e2e2",
  green = "#8bd49c",
  yellow = "#e3c472",
  red = "#cf6a4c",
  magenta = "#a37acc",
  gray = "#4d5256",
  brblue = "#45aaf2",
}
local function hi(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

hi("Normal", { fg = c.fg, bg = c.bg })
hi("Comment", { fg = c.gray, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green })
hi("Function", { fg = c.blue })
hi("Keyword", { fg = c.brblue, bold = true })
hi("Type", { fg = c.yellow })
hi("Identifier", { fg = c.fg })
hi("Statement", { fg = c.magenta })
hi("Error", { fg = c.red })
hi("LineNr", { fg = c.gray })
hi("CursorLineNr", { fg = c.brblue, bold = true })
hi("Visual", { bg = c.gray })
hi("Pmenu", { fg = c.fg, bg = "#16191c" })
hi("PmenuSel", { fg = c.bg, bg = c.blue })
