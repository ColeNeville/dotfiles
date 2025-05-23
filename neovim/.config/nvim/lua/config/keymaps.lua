local wk = require("which-key")

-- Register which-key mappings using the newer format
wk.add({
  -- File operations
  { "<leader>f", group = "File" },
  { "<leader>ff", "<cmd>lua vim.fn.feedkeys(':find ')<CR>", desc = "Find File" },
  { "<leader>fr", "<cmd>lua vim.fn.feedkeys(':e ')<CR>", desc = "Recent Files" },
  
  -- Buffer operations
  { "<leader>b", group = "Buffer" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
  { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete Buffer" },
  
  -- Project operations
  { "<leader>p", group = "Project" },
  
  -- AI operations
  { "<leader>A", group = "AI" },
  
  -- Window management
  { "<leader>w", group = "Window" },
  { "<leader>wv", "<cmd>vsplit<CR>", desc = "Split Vertical" },
  { "<leader>ws", "<cmd>split<CR>", desc = "Split Horizontal" },
  { "<leader>wq", "<cmd>q<CR>", desc = "Close Window" },
  { "<leader>wh", "<cmd>wincmd h<CR>", desc = "Move Left" },
  { "<leader>wj", "<cmd>wincmd j<CR>", desc = "Move Down" },
  { "<leader>wk", "<cmd>wincmd k<CR>", desc = "Move Up" },
  { "<leader>wl", "<cmd>wincmd l<CR>", desc = "Move Right" },
  { "<leader>w=", "<cmd>wincmd =<CR>", desc = "Equal Size" },
  { "<leader>w>", "<cmd>wincmd ><CR>", desc = "Increase Width" },
  { "<leader>w<", "<cmd>wincmd <<CR>", desc = "Decrease Width" },
  { "<leader>w+", "<cmd>wincmd +<CR>", desc = "Increase Height" },
  { "<leader>w-", "<cmd>wincmd -<CR>", desc = "Decrease Height" },
})

-- Basic keymaps (not using which-key)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- Direct window navigation with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window' })
