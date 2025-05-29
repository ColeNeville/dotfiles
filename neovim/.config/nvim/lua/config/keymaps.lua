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

    -- ================================================================
    -- WINDOW AND TAB MANAGEMENT
    -- ================================================================
    { "<leader>w", group = "Window Management" },
    {
      "<leader>wv",
      "<cmd>vsplit<cr>",
      desc = "Split window vertically"
    },
    {
      "<leader>wh",
      "<cmd>split<cr>",
      desc = "Split window horizontally"
    },
    {
      "<leader>wc",
      "<cmd>close<cr>",
      desc = "Close current window"
    },
    {
      "<leader>wo",
      "<cmd>only<cr>",
      desc = "Close all other windows"
    },
    {
      "<leader>w=",
      "<C-w>=",
      desc = "Equalize window sizes"
    },

    { "<leader>T", group = "Tab Management" },
    {
      "<leader>Tn",
      "<cmd>tabnew<cr>",
      desc = "New tab"
    },
    {
      "<leader>Tc",
      "<cmd>tabclose<cr>",
      desc = "Close tab"
    },
    {
      "<leader>To",
      "<cmd>tabonly<cr>",
      desc = "Close all other tabs"
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
    {
      "<leader>lS",
      function() require('telescope.builtin').lsp_workspace_symbols() end,
      desc = "Show workspace symbols (Telescope)"
    },
    {
      "<leader>lt",
      function() vim.lsp.buf.type_definition() end,
      desc = "Go to type definition (LSP)"
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
    {
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Toggle workspace diagnostics (Trouble)",
    },
    {
      "<leader>tn",
      function()
        vim.opt.number = not vim.opt.number:get()
        print("Line numbers " .. (vim.opt.number:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle line numbers"
    },
    {
      "<leader>tr",
      function()
        vim.opt.relativenumber = not vim.opt.relativenumber:get()
        print("Relative numbers " .. (vim.opt.relativenumber:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle relative numbers"
    },
    {
      "<leader>ts",
      function()
        vim.opt.spell = not vim.opt.spell:get()
        print("Spell check " .. (vim.opt.spell:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle spell check"
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
    -- CLIPBOARD AND CONFIG
    -- ================================================================
    { "<leader>y", group = "Clipboard Operations" },
    {
      "<leader>yy",
      '"+yy',
      desc = "Copy line to system clipboard"
    },
    {
      "<leader>yp",
      '"+p',
      desc = "Paste from system clipboard"
    },

    { "<leader>c", group = "Config & Settings" },
    {
      "<leader>cv",
      "<cmd>edit $MYVIMRC<cr>",
      desc = "Edit Neovim config"
    },
    {
      "<leader>cr",
      "<cmd>source $MYVIMRC<cr>",
      desc = "Reload Neovim config"
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
    { "]e", function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, desc = "Next error" },
    { "[e", function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, desc = "Previous error" },
    { "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
    { "[t", "<cmd>tabprevious<cr>", desc = "Previous tab" },

    -- Window navigation
    { "<C-h>", "<C-w>h", desc = "Move to left window" },
    { "<C-j>", "<C-w>j", desc = "Move to bottom window" },
    { "<C-k>", "<C-w>k", desc = "Move to top window" },
    { "<C-l>", "<C-w>l", desc = "Move to right window" },

    -- ================================================================
    -- QUICK UTILITIES
    -- ================================================================
    { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlight" },
    { "J", "mzJ`z", desc = "Join lines and keep cursor position" },
    { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
    { "<C-u>", "<C-u>zz", desc = "Half page up and center" },
    { "n", "nzzzv", desc = "Next search result and center" },
    { "N", "Nzzzv", desc = "Previous search result and center" },
  },

  -- ================================================================
  -- VISUAL MODE KEYMAPS
  -- ================================================================
  { mode = { "v" }, -- Visual mode keymaps
    {
      "<leader>y",
      '"+y',
      desc = "Copy selection to system clipboard"
    },
    {
      "<",
      "<gv",
      desc = "Indent left and reselect"
    },
    {
      ">",
      ">gv",
      desc = "Indent right and reselect"
    },
    {
      "J",
      ":m '>+1<CR>gv=gv",
      desc = "Move selection down"
    },
    {
      "K",
      ":m '<-2<CR>gv=gv",
      desc = "Move selection up"
    },
  },

  -- ================================================================
  -- INSERT MODE KEYMAPS
  -- ================================================================
  { mode = { "i" }, -- Insert mode keymaps
    {
      "<C-c>",
      "<Esc>",
      desc = "Exit insert mode"
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
-- All keymaps are now centralized in this file for better
-- discoverability and maintenance.
