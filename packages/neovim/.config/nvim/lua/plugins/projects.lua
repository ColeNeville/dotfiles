-- neovim/.config/nvim/lua/plugins/project.lua
return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim"
      },
    },
    keys = {
      {
        "<leader>pp",
        function()
          local actions = require("telescope.actions")
          local find_project_files = require("utils.project").find_file_in_selection

          -- TODO: Figure out how to add the default mappings from project.nvim
          -- https://github.com/ahmedkhalf/project.nvim/blob/main/lua/telescope/_extensions/projects.lua#L152-L172
          local opts = {
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(find_project_files)
              return true
            end,
          }

          require('telescope').extensions.projects.projects(opts)
        end,
        desc = "Switch project (Project)",
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)

      -- Load the Telescope extension provided by project.nvim.
      pcall(require('telescope').load_extension, 'projects')
    end,
  },
}
