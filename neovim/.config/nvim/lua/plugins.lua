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
