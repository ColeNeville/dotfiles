-- neovim/.config/nvim/lua/config/keymaps/navigation.lua
-- Navigation, search, buffers, marks, and jumps keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- BUFFER OPERATIONS
    -- ================================================================
    { "<leader>b", group = "Buffer Operations" },
    {
      "<leader>bb",
      function() require('telescope.builtin').buffers({}) end,
      desc = "Search buffers (Telescope)",
    },
    {
      "<leader>bd",
      "<cmd>bdelete<cr>",
      desc = "Delete buffer"
    },
    {
      "<leader>bD",
      "<cmd>%bdelete|edit#|normal `\"<cr>",
      desc = "Delete all buffers except current"
    },
    {
      "<leader>bn",
      "<cmd>bnext<cr>",
      desc = "Next buffer"
    },
    {
      "<leader>bp",
      "<cmd>bprevious<cr>",
      desc = "Previous buffer"
    },

    -- ================================================================
    -- SEARCH & SESSIONS
    -- ================================================================
    { "<leader>s", group = "Search & Sessions" },
    {
      "<leader>ss",
      function() require('auto-session.session-lens').search_session() end,
      desc = "Search sessions (Auto Session)",
    },
    {
      "<leader>sd",
      function() require('telescope.builtin').live_grep() end,
      desc = "Search in directory (Telescope)",
    },
    {
      "<leader>sw",
      function() require('telescope.builtin').grep_string() end,
      desc = "Search word under cursor (Telescope)"
    },
    {
      "<leader>sh",
      function() require('telescope.builtin').help_tags() end,
      desc = "Search help (Telescope)"
    },
    {
      "<leader>sk",
      function() require('telescope.builtin').keymaps() end,
      desc = "Search keymaps (Telescope)"
    },
    {
      "<leader>sc",
      function() require('telescope.builtin').command_history() end,
      desc = "Search command history (Telescope)"
    },
    {
      "<leader>sr",
      function() require('telescope.builtin').resume() end,
      desc = "Resume last search (Telescope)"
    },

    -- ================================================================
    -- MARKS & JUMPS
    -- ================================================================
    { "<leader>m", group = "Marks & Jumps" },
    {
      "<leader>mm",
      function() require('telescope.builtin').marks() end,
      desc = "Search marks (Telescope)"
    },
    {
      "<leader>mj",
      function() require('telescope.builtin').jumplist() end,
      desc = "Search jump list (Telescope)"
    },

    -- ================================================================
    -- NAVIGATION SHORTCUTS
    -- ================================================================
    { "]b", "<cmd>bnext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>bprevious<cr>", desc = "Previous buffer" },
    { "]d", function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
    { "[d", function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
    { "]e", function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, desc = "Next error" },
    { "[e", function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, desc = "Previous error" },

    -- ================================================================
    -- SEARCH NAVIGATION
    -- ================================================================
    { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlight" },
    { "n", "nzzzv", desc = "Next search result and center" },
    { "N", "Nzzzv", desc = "Previous search result and center" },
  },
})
