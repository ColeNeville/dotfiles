-- neovim/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        pickers = {
          find_files = {
            hidden = true, -- Always show hidden files (dotfiles)
          },
        },
      },
    })
    -- Extensions are typically loaded after the providing plugin is also configured.
    -- We will load the 'projects' extension in project.nvim's config.
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require('telescope.builtin').find_files({})
      end,
      desc = "Find Files (Telescope)", mode = "n", noremap = true, silent = true,
    },
  },
}
