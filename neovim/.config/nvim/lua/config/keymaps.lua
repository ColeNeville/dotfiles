-- neovim/.config/nvim/lua/config/keymaps.lua

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Default mode for these registrations
    -- Group definitions for plugin-based bindings.
    -- Their actual keybindings (<leader>ff, <leader>pp) are defined in plugins.lua
    -- and will be automatically associated by which-key due to the shared prefix and 'desc' attribute.
    { "<leader>f", group = "File" },
    { "<leader>p", group = "Project" },

    -- Group definition with its own sub-bindings defined here
    {
      "<leader>q", -- Prefix for the group
      name = "Quit/Session", -- 'name' is an alias for 'group'
      -- Sub-bindings for the <leader>q group
      { "s", "<cmd>qa<cr>", desc = "Quit All (Safe)" }, -- Becomes <leader>qs
      { "f", "<cmd>qa!<cr>", desc = "Quit All (Force)" }, -- Becomes <leader>qf
    },
  },
  -- You can add other groups or individual keymaps here, for example:
  -- {
  --   mode = { "n" },
  --   { "<leader>s", group = "Search" },
  --   { "<leader>sg", "<cmd> Telescope live_grep <cr>", desc = "Live Grep" },
  -- }
})

-- If you still want to use vim.keymap.set for some other global keybindings, you can do so here:
-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
-- keymap("n", "<leader>xy", "<cmd>echo 'Other mapping'<cr>", { desc = "Other Mapping", noremap = true, silent = true })
