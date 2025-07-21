return {
  {
    "echasnovski/mini.starter",
    version = "*",
    lazy = false,
    priority = 1000,
    opts = {
      header = [=[
   __     ____      _  
  / _|   |___ \    | | 
 | |_ _ __ __) | __| | 
 |  _| '__|__ < / _` | 
 | | | |  ___) | (_| | 
 |_| |_| |____/ \__,_| 
                       
                       
        ]=],
      footer = "home lab",
      items = {
        { name = "Edit new buffer", action = "enew", section = "Commands" },
        { name = "Quit Neovim", action = "qall", section = "Commands" },
        { name = "Terminal", action = "terminal", section = "Commands" },
        { name = "Files", action = "FzfLua files", section = "Commands" },
      },
      function()
        require("mini.starter").setup()
      end,
    },
  },
  -- { "echasnovski/mini.statusline", version = "*" },
}
