-- neovim/.config/nvim/lua/config/keymaps.lua
-- Centralized keymap loader - imports all keymap modules
-- This file serves as the main entry point for all keymaps

-- Load all keymap modules

local wk = require("which-key")

wk.add({
  {
    mode = { "n" },
    {
      "<leader>A",
      group = "AI Assistant (Aider)",
      mode = { "n", "v" }, -- Visual mode for region related tasks
    },

    { "<leader>b",  group = "Buffer Operations" },
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

    { "<leader>e",  group = "Explorer" },
    { "<leader>f",  group = "File Operations" },
    { "<leader>g",  group = "Git Operations" },
    { "<leader>l",  group = "LSP & Language Tools" },
    { "<leader>p",  group = "Project Management" },

    { "<leader>q",  group = "Quit Operations" },
    { "<leader>qq", "<cmd>quitall<cr>",             desc = "Quit all (safe - checks for unsaved changes)" },
    { "<leader>qQ", "<cmd>quitall!<cr>",            desc = "Force quit all (unsafe - discards changes)" },

    { "<leader>s",  group = "Search & Sessions" },

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

    { "<leader>t",  group = "Toggles & Diagnostics" },
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
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Show buffer keymaps (Which Key)",
    },

    { "]b",    "<cmd>bnext<cr>",      desc = "Next buffer" },
    { "[b",    "<cmd>bprevious<cr>",  desc = "Previous buffer" },
    { "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
    { "[t", "<cmd>tabprevious<cr>", desc = "Previous tab" },

    { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlight" },
    { "n",     "nzzzv",               desc = "Next search result and center" },
    { "N",     "Nzzzv",               desc = "Previous search result and center" },

    { "J",     "mzJ`z",               desc = "Join lines and keep cursor position" },
    { "<C-d>", "<C-d>zz",             desc = "Half page down and center" },
    { "<C-u>", "<C-u>zz",             desc = "Half page up and center" },
  },
  {
    mode = { "v" },
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
  {
    mode = {  "t" },
    {
      "<C-Esc>",
      "<C-\\><C-n>",
    }
  }
})

-- ================================================================
-- NOTES FOR DEVELOPERS
-- ================================================================
--
-- This file loads all keymap modules in a logical order.
-- Each module is responsible for a specific area of functionality.
--
-- To add new keymaps:
-- 1. Find the appropriate module in config/keymaps/
-- 2. Add your keymap to that module
-- 3. If no appropriate module exists, create a new one and require it here
--
-- Module organization:
-- - file-operations: File and project management
-- - window-management: Windows and tabs
-- - navigation: Buffers, search, marks, jumps
-- - development: LSP, language tools, diagnostics
-- - git: Git operations
-- - toggles: UI toggles and settings
-- - ai-assistant: AI tools (Aider)
-- - system: Quit operations, config management
-- - utilities: Quick shortcuts and conveniences
