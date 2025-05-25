-- neovim/.config/nvim/lua/plugins/project.lua
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("project_nvim").setup({
      -- Using default settings for project.nvim for a skeleton.
    })
    -- Load the Telescope extension provided by project.nvim.
    pcall(require('telescope').load_extension, 'projects')
  end,
  keys = {
    {
      "<leader>pp",
      function()
        require('telescope').extensions.projects.projects{}
      end,
      desc = "Open Project (project.nvim)", mode = "n", noremap = true, silent = true,
    },
  },
}
