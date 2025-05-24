-- neovim/.config/nvim/lua/plugins.lua

return {
  -- Example: A colorscheme
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is a colorscheme
  --   priority = 1000, -- make sure to load this before all other start plugins
  --   config = function()
  --     vim.cmd.colorscheme "tokyonight"
  --   end,
  -- },

  -- Add your plugins here:
  -- e.g.
  -- { "nvim-lua/plenary.nvim" }, -- Utility functions
  -- { "nvim-telescope/telescope.nvim", tag = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

  -- You can also group plugins into files, e.g., lua/plugins/ui.lua, lua/plugins/lsp.lua
  -- and then import them here:
  -- require("plugins.ui"),
  -- require("plugins.lsp"),
}
