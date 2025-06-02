-- neovim/.config/nvim/lua/plugins/theme.lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Make sure to load this before all other start plugins
    lazy = false,  -- Load on startup
    config = function()
      require("gruvbox").setup({})
      vim.cmd.colorscheme "gruvbox"
    end,
  },
}
