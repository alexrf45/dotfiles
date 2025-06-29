-- Using lazy.nvim
return {
  "cdmill/neomodern.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neomodern").setup({
      theme = "roseprime",
      variant = "dark",
      alt_bg = true,

      -- optional configuration here
    })
    require("neomodern").load()
  end,
}
