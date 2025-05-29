-- neovim/.config/nvim/lua/config/keymaps.lua
-- Centralized keymap definitions using which-key
-- Organized by functionality for better maintainability

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- FILE AND PROJECT MANAGEMENT
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

    { "<leader>p", group = "Project Management" },
    {
      "<leader>pp",
      function() require('telescope').extensions.projects.projects{} end,
      desc = "Switch project (Project)",
    },

    { "<leader>e", group = "File Explorer" },
    {
      "<leader>ee",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle explorer (Nvim Tree)"
    },

    -- ================================================================
    -- NAVIGATION AND SEARCH
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

    -- ================================================================
    -- DEVELOPMENT TOOLS
    -- ================================================================
    { "<leader>l", group = "LSP & Language Tools" },
    {
      "<leader>lm",
      "<cmd>Mason<cr>",
      desc = "Open package manager (Mason)",
    },
    {
      "<leader>lf",
      function() vim.lsp.buf.format() end,
      desc = "Format buffer (LSP)"
    },
    {
      "<leader>la",
      function() vim.lsp.buf.code_action() end,
      desc = "Code actions (LSP)"
    },
    {
      "<leader>lr",
      function() vim.lsp.buf.rename() end,
      desc = "Rename symbol (LSP)"
    },
    {
      "<leader>ld",
      function() vim.lsp.buf.definition() end,
      desc = "Go to definition (LSP)"
    },
    {
      "<leader>lh",
      function() vim.lsp.buf.hover() end,
      desc = "Show hover info (LSP)"
    },
    {
      "<leader>lR",
      function() require('telescope.builtin').lsp_references() end,
      desc = "Show references (Telescope)"
    },
    {
      "<leader>li",
      function() require('telescope.builtin').lsp_implementations() end,
      desc = "Show implementations (Telescope)"
    },
    {
      "<leader>ls",
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = "Show document symbols (Telescope)"
    },

    { "<leader>t", group = "Toggles & Diagnostics" },
    {
      "<leader>tw",
      function()
        vim.opt.wrap = not vim.opt.wrap:get()
        if vim.opt.wrap:get() then
          print("Word wrap enabled")
        else
          print("Word wrap disabled")
        end
      end,
      desc = "Toggle word wrap (Vim)",
    },
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Toggle buffer diagnostics (Trouble)",
    },

    -- ================================================================
    -- AI ASSISTANCE (AIDER)
    -- ================================================================
    { "<leader>A", group = "AI Assistant (Aider)" },
    {
      "<leader>Aa",
      "<cmd>Aider toggle<cr>",
      desc = "Toggle panel (Aider)",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send selection/buffer (Aider)",
      mode = {"n", "v"},
    },
    {
      "<leader>Af",
      "<cmd>Aider add<cr>",
      desc = "Add current file (Aider)",
    },
    {
      "<leader>Ab",
      "<cmd>Aider buffer<cr>",
      desc = "Add buffer content (Aider)",
    },
    {
      "<leader>Ac",
      "<cmd>Aider command<cr>",
      desc = "Run custom command (Aider)",
    },
    {
      "<leader>AR",
      "<cmd>Aider reset<cr>",
      desc = "Reset session (Aider)",
    },

    -- ================================================================
    -- SYSTEM OPERATIONS
    -- ================================================================
    { "<leader>q", group = "Quit Operations" },
    { "<leader>qq", "<cmd>quitall<cr>", desc = "Quit all (safe - checks for unsaved changes)" },
    { "<leader>qQ", "<cmd>quitall!<cr>", desc = "Force quit all (unsafe - discards changes)" },

    -- ================================================================
    -- HELP AND DISCOVERY
    -- ================================================================
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Show buffer keymaps (Which Key)",
    },

    -- ================================================================
    -- NAVIGATION SHORTCUTS
    -- ================================================================
    { "]b", "<cmd>bnext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>bprevious<cr>", desc = "Previous buffer" },
    { "]d", function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
    { "[d", function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },

    -- ================================================================
    -- QUICK UTILITIES
    -- ================================================================
    { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlight" },
  },
})

-- ================================================================
-- NOTES FOR DEVELOPERS
-- ================================================================
--
-- Organization principles:
-- 1. Keymaps are grouped by functionality rather than plugin
-- 2. Each section has a clear header and description
-- 3. Descriptions are consistent and informative
-- 4. Plugin names are included in descriptions for clarity
--
-- Adding new keymaps:
-- 1. Find the appropriate functional section
-- 2. Add to existing group or create new group if needed
-- 3. Use descriptive names that include the plugin name
-- 4. Follow the existing format and indentation
--
-- All keymaps are now centralized in this file for better
-- discoverability and maintenance.
