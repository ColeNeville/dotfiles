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
})

-- Basic keymaps (not using which-key)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
