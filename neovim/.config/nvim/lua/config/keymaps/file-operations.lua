-- neovim/.config/nvim/lua/config/keymaps/file-operations.lua
-- File and project management keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- FILE OPERATIONS
    -- ================================================================
    { "<leader>f", group = "File Operations" },
    {
      "<leader>ff",
      function() require('telescope.builtin').find_files({}) end,
      desc = "Find files (Telescope)"
    },
    {
      "<leader>fr",
      function() require('telescope.builtin').oldfiles() end,
      desc = "Recent files (Telescope)"
    },

    -- ================================================================
    -- PROJECT MANAGEMENT
    -- ================================================================
    {
      "<leader>p",
      function() require('telescope').extensions.projects.projects{} end,
      desc = "Switch project (Project)",
    },

    -- ================================================================
    -- FILE EXPLORER
    -- ================================================================
    {
      "<leader>e",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle explorer (Nvim Tree)"
    },
  },
})
