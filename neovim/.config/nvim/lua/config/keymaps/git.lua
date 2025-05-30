-- neovim/.config/nvim/lua/config/keymaps/git.lua
-- Git operations keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- GIT OPERATIONS
    -- ================================================================
    { "<leader>g", group = "Git Operations" },
    {
      "<leader>gl",
      function()
        if _G.toggle_lazygit_float then
          _G.toggle_lazygit_float()
        else
          vim.notify("Toggleterm Lazygit function not initialized.", vim.log.levels.ERROR)
        end
      end,
      desc = "Toggle Lazygit (Float)",
    },
  },
})
