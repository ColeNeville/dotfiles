-- neovim/.config/nvim/lua/config/keymaps/git.lua
-- Git operations keymaps

local wk = require("which-key")
local lazygit = require("utils.lazygit")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- GIT OPERATIONS
    -- ================================================================
    { "<leader>g", group = "Git Operations" },
    {
      "<leader>gg",
      lazygit.toggle_lazygit_float,
      desc = "Open Lazygit (Custom)",
    },
  },
})
