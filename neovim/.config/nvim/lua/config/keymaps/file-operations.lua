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
    {
      "<leader>fs",
      "<cmd>write<cr>",
      desc = "Save file"
    },
    {
      "<leader>fS",
      "<cmd>wall<cr>",
      desc = "Save all files"
    },
    {
      "<leader>fn",
      "<cmd>enew<cr>",
      desc = "New file"
    },

    -- ================================================================
    -- PROJECT MANAGEMENT
    -- ================================================================
    { "<leader>p", group = "Project Management" },
    {
      "<leader>pp",
      function() require('telescope').extensions.projects.projects{} end,
      desc = "Switch project (Project)",
    },

    -- ================================================================
    -- FILE EXPLORER
    -- ================================================================
    { "<leader>e", group = "File Explorer" },
    {
      "<leader>ee",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle explorer (Nvim Tree)"
    },
    {
      "<leader>ef",
      "<cmd>NvimTreeFindFile<CR>",
      desc = "Find current file in explorer (Nvim Tree)"
    },
    {
      "<leader>er",
      "<cmd>NvimTreeRefresh<CR>",
      desc = "Refresh explorer (Nvim Tree)"
    },
  },
})
