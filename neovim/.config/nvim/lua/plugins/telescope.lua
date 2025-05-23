return {
  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.4',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('telescope').setup({})
      
      -- Key mappings for telescope
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
    end,
  },
  
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("project_nvim").setup({
        -- detection_methods = { "pattern", "lsp" },
        -- patterns = { ".git", "Makefile", "package.json" },
      })
      require('telescope').load_extension('projects')
      
      -- Key mapping for project management
      vim.keymap.set('n', '<leader>pp', function() require'telescope'.extensions.projects.projects{} end, 
        { desc = "Find projects" })
      vim.keymap.set('n', '<leader>pa', function() require('project_nvim.project').add_project() end, 
        { desc = "Add current directory as project" })
    end,
  },
}
