-- neovim/.config/nvim/lua/config/keymaps/window-management.lua
-- Window and tab management keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- WINDOW MANAGEMENT
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

    -- ================================================================
    -- TAB MANAGEMENT
    -- ================================================================
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
    -- WINDOW NAVIGATION
    -- ================================================================
    { "<C-h>", "<C-w>h", desc = "Move to left window" },
    { "<C-j>", "<C-w>j", desc = "Move to bottom window" },
    { "<C-k>", "<C-w>k", desc = "Move to top window" },
    { "<C-l>", "<C-w>l", desc = "Move to right window" },

    -- ================================================================
    -- TAB NAVIGATION
    -- ================================================================
    { "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
    { "[t", "<cmd>tabprevious<cr>", desc = "Previous tab" },
  },
})
