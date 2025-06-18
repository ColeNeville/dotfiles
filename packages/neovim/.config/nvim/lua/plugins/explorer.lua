return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*", -- Pin to latest stable release
    lazy = false,  -- Load on startup
    keys = {
      mode = { "n" },
      {
        "<leader>ee",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Toggle explorer (Nvim Tree)"
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- For file icons (recommended for default experience)
      "ahmedkhalf/project.nvim",
    },
    config = function()
      -- Disable netrw, as nvim-tree will be the file explorer
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      local function open_nvim_tree(data)
        require("nvim-tree.api").tree.open()
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  },
}
