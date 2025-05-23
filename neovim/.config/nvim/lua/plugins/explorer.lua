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
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle file explorer" })
      vim.keymap.set('n', '<leader>fe', ':NvimTreeFocus<CR>', { desc = "Focus file explorer" })
    end,
  },
}
