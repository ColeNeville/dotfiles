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

    { "<leader>p", group = "Project Management" },
    {
      "<leader>pp",
      function() require('telescope').extensions.projects.projects{} end,
      desc = "Switch project (project.nvim)",
    },

    { "<leader>E", group = "File Explorer" },
    -- Note: nvim-tree keymaps are defined in the plugin config

    -- ================================================================
    -- NAVIGATION AND SEARCH
    -- ================================================================
    { "<leader>b", group = "Buffer Operations" },
    {
      "<leader>bb",
      function() require('telescope.builtin').buffers({}) end,
      desc = "Search open buffers (Telescope)",
    },

    { "<leader>s", group = "Session Management" },
    {
      "<leader>ss",
      function() require('auto-session.session-lens').search_session() end,
      desc = "Search and restore sessions (auto-session)",
    },

    -- ================================================================
    -- DEVELOPMENT TOOLS
    -- ================================================================
    { "<leader>l", group = "LSP & Language Tools" },
    {
      "<leader>lm",
      "<cmd>Mason<cr>",
      desc = "Open Mason package manager",
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
      desc = "Show references (LSP + Telescope)"
    },
    {
      "<leader>li",
      function() require('telescope.builtin').lsp_implementations() end,
      desc = "Show implementations (LSP + Telescope)"
    },
    {
      "<leader>ls",
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = "Document symbols (LSP + Telescope)"
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
      desc = "Toggle word wrap",
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
      desc = "Toggle Aider panel",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send selection/buffer to Aider",
      mode = {"n", "v"},
    },
    {
      "<leader>Af",
      "<cmd>Aider add<cr>",
      desc = "Add current file to Aider context",
    },
    {
      "<leader>Ab",
      "<cmd>Aider buffer<cr>",
      desc = "Add buffer content to Aider context",
    },
    {
      "<leader>Ac",
      "<cmd>Aider command<cr>",
      desc = "Run custom Aider command",
    },
    {
      "<leader>AR",
      "<cmd>Aider reset<cr>",
      desc = "Reset Aider session",
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
      desc = "Show buffer-local keymaps (which-key)",
    },
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
-- Some plugin-specific keymaps are defined in their respective
-- plugin configuration files (e.g., nvim-tree, LSP keymaps)
