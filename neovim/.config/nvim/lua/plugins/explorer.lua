return {
  -- nvim-tree file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      
      -- Key mappings for nvim-tree
      vim.keymap.set('n', '<leader>E', ':NvimTreeToggle<CR>', { desc = "Toggle Explorer" })
      vim.keymap.set('n', '<leader>Ef', ':NvimTreeFocus<CR>', { desc = "Focus Explorer" })
    end,
  },
}
