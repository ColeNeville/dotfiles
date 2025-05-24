-- neovim/.config/nvim/lua/config/options.lua

-- Set background color scheme (dark or light)
vim.o.background = "dark"

local opt = vim.opt -- for conciseness

-- General
opt.mouse = "a"               -- enable mouse support in all modes
opt.clipboard = "unnamedplus" -- use system clipboard
opt.swapfile = false          -- disable swapfile creation
opt.backup = false            -- disable backup file creation
opt.undofile = true           -- enable persistent undo

-- UI
opt.number = true             -- show line numbers
opt.relativenumber = true     -- show relative line numbers
opt.termguicolors = true      -- enable 24-bit RGB color in the TUI
opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text
opt.scrolloff = 8             -- keep 8 lines visible above/below the cursor
opt.sidescrolloff = 8         -- keep 8 columns visible left/right of the cursor
opt.wrap = false              -- disable line wrapping
opt.list = true               -- show invisible characters (tabs, trailing spaces)
opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' } -- characters for list

-- Tabs & Indentation
opt.tabstop = 2               -- number of visual spaces per TAB
opt.softtabstop = 2           -- number of spaces in tab when editing
opt.shiftwidth = 2            -- number of spaces to use for autoindent
opt.expandtab = true          -- use spaces instead of tabs
opt.autoindent = true         -- copy indent from current line when starting a new one
opt.smartindent = true        -- make indenting smarter

-- Search
opt.hlsearch = true           -- highlight all matches on search
opt.incsearch = true          -- show search results incrementally
opt.ignorecase = true         -- ignore case in search patterns
opt.smartcase = true          -- override ignorecase if search pattern has uppercase letters

-- Performance
opt.updatetime = 250          -- faster completion (default 4000ms)
opt.timeoutlen = 300          -- time to wait for a mapped sequence to complete (in milliseconds)

-- Folding (sensible defaults, can be customized further with plugins)
-- opt.foldmethod = "indent"     -- fold based on indent
-- opt.foldlevelstart = 99       -- open all folds by default

-- If you have a recent Neovim version, you might want to set up LSP signature help to not float
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, {
--     border = "rounded"
--   }
-- )
