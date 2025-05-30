-- neovim/.config/nvim/lua/config/keymaps/system.lua
-- System operations, config management, and quit operations keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- CLIPBOARD OPERATIONS
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

    -- ================================================================
    -- CONFIG & SETTINGS
    -- ================================================================
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
    -- QUIT OPERATIONS
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
  },

  -- ================================================================
  -- VISUAL MODE CLIPBOARD
  -- ================================================================
  { mode = { "v" }, -- Visual mode keymaps
    {
      "<leader>y",
      '"+y',
      desc = "Copy selection to system clipboard"
    },
  },
})
