-- neovim/.config/nvim/lua/config/keymaps/utilities.lua
-- Quick utilities, shortcuts, and convenience keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- QUICK UTILITIES
    -- ================================================================
    { "J", "mzJ`z", desc = "Join lines and keep cursor position" },
    { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
    { "<C-u>", "<C-u>zz", desc = "Half page up and center" },
  },

  -- ================================================================
  -- VISUAL MODE UTILITIES
  -- ================================================================
  { mode = { "v" }, -- Visual mode keymaps
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
  -- INSERT MODE UTILITIES
  -- ================================================================
  { mode = { "i" }, -- Insert mode keymaps
    {
      "<C-c>",
      "<Esc>",
      desc = "Exit insert mode"
    },
  },
})
