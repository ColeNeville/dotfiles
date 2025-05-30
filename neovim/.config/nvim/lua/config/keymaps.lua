-- neovim/.config/nvim/lua/config/keymaps.lua
-- Centralized keymap loader - imports all keymap modules
-- This file serves as the main entry point for all keymaps

-- Load all keymap modules
require("config.keymaps.file-operations")
require("config.keymaps.window-management")
require("config.keymaps.navigation")
require("config.keymaps.development")
require("config.keymaps.git")
require("config.keymaps.toggles")
require("config.keymaps.ai-assistant")
require("config.keymaps.system")
require("config.keymaps.utilities")

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
