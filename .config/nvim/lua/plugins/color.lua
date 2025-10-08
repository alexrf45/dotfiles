return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nordic").load()
  end,
}

-- return {
--   "vague2k/vague.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other plugins
--   config = function()
--     require("vague").setup({
--       colors = {
--         bg = "#000000",
--         inactiveBg = "#1c1c24",
--         fg = "#cdcdcd",
--         floatBorder = "#878787",
--         line = "#252530",
--         comment = "#606079",
--         builtin = "#b4d4cf",
--         func = "#c48282",
--         string = "#e8b589",
--         number = "#e0a363",
--         property = "#c3c3d5",
--         constant = "#aeaed1",
--         parameter = "#bb9dbd",
--         visual = "#333738",
--         error = "#d8647e",
--         warning = "#f3be7c",
--         hint = "#7e98e8",
--         operator = "#90a0b5",
--         keyword = "#6e94b2",
--         type = "#9bb4bc",
--         search = "#405065",
--         plus = "#7fa563",
--         delta = "#f3be7c",
--       },
--     })
--     vim.cmd("colorscheme vague")
--   end,
-- }
