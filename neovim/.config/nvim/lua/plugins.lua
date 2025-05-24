-- neovim/.config/nvim/lua/plugins.lua

return {
  -- which-key.nvim: For displaying keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load when needed
    opts = {
      -- Minimal options:
      -- This filter will hide keymaps that don't have a 'desc' field,
      -- keeping the which-key popup clean.
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      -- Most other settings will use which-key's defaults.
      -- You can add more specific 'opts' here later if needed.
      -- For example, to customize the window appearance:
      -- window = {
      --   border = "rounded", -- 'none', 'single', 'double', 'shadow', 'rounded'
      -- },
      -- To enable built-in presets for common Vim commands:
      -- presets = {
      --   operators = true,
      --   motions = true,
      --   text_objects = true,
      --   windows = true,
      --   nav = true,
      --   z = true,
      --   g = true,
      -- },
    },
    keys = {
      -- Example keymap provided by which-key for buffer-local mappings
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- nvim-tree.lua: File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*", -- Pin to latest stable release
    lazy = false,  -- Load on startup
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- For file icons (recommended for default experience)
    },
    config = function()
      -- Disable netrw, as nvim-tree will be the file explorer
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Call setup with an empty table to ensure default settings are applied.
      -- nvim-tree generally works well with its defaults.
      require("nvim-tree").setup({})
    end,
    keys = {
      -- These keymaps are defined here so lazy.nvim manages them.
      -- Without a 'desc' field, they won't show up in which-key by default with your current filter.
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", mode = "n", noremap = true, silent = true },
    },
  },

  -- Example: A colorscheme (uncomment and configure if you add one)
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme "tokyonight"
  --   end,
  -- },

  -- Add other plugins here:
  -- e.g.
  -- { "nvim-lua/plenary.nvim" }, -- Utility functions
  -- { "nvim-telescope/telescope.nvim", tag = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

  -- You can also group plugins into files, e.g., lua/plugins/ui.lua, lua/plugins/lsp.lua
  -- and then import them here:
  -- require("plugins.ui"),
  -- require("plugins.lsp"),
}
