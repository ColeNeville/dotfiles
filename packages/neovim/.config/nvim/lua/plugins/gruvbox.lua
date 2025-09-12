-- neovim/.config/nvim/lua/plugins/theme.lua
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- Make sure to load this before all other start plugins
  lazy = false, -- Load on startup
  opts = {
    contrast = "hard",
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd.colorscheme("gruvbox")
  end,
}
