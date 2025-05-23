return {
  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.4',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = "Find files" },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "Find buffers" },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
    },
    config = function()
      require('telescope').setup({})
    end,
  },
  
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { '<leader>pp', function() require('telescope').extensions.projects.projects{} end, desc = "Find projects" },
      { '<leader>pa', function() require('project_nvim.project').add_project() end, desc = "Add current directory as project" },
    },
    config = function()
      require("project_nvim").setup({
        -- detection_methods = { "pattern", "lsp" },
        -- patterns = { ".git", "Makefile", "package.json" },
      })
      require('telescope').load_extension('projects')
    end,
  },
}
