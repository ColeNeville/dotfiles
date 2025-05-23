local wk = require("which-key")

-- Register which-key mappings
wk.register({
  -- Example mappings
  f = {
    name = "File",
    f = { "<cmd>lua vim.fn.feedkeys(':find ')<CR>", "Find File" },
    r = { "<cmd>lua vim.fn.feedkeys(':e ')<CR>", "Recent Files" },
  },
  b = {
    name = "Buffer",
    n = { "<cmd>bnext<CR>", "Next Buffer" },
    p = { "<cmd>bprevious<CR>", "Previous Buffer" },
    d = { "<cmd>bdelete<CR>", "Delete Buffer" },
  },
}, { prefix = "<leader>" })

-- Basic keymaps (not using which-key)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
