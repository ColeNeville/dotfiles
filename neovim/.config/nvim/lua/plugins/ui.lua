return {
  -- Which-key for displaying key bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
      })
    end,
  },
  
  -- Required dependency for nvim-aider
  {
    "folke/snacks.nvim",
    lazy = false,
  },
  
  -- You can add more UI plugins here like:
  -- Status line, bufferline, colorscheme, etc.
}
