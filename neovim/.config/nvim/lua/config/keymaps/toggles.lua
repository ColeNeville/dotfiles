-- neovim/.config/nvim/lua/config/keymaps/toggles.lua
-- UI toggles, diagnostics, and settings keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- TOGGLES & DIAGNOSTICS
    -- ================================================================
    { "<leader>t", group = "Toggles & Diagnostics" },
    {
      "<leader>tw",
      function()
        vim.opt.wrap = not vim.opt.wrap:get()
        if vim.opt.wrap:get() then
          print("Word wrap enabled")
        else
          print("Word wrap disabled")
        end
      end,
      desc = "Toggle word wrap (Vim)",
    },
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Toggle buffer diagnostics (Trouble)",
    },
    {
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Toggle workspace diagnostics (Trouble)",
    },
    {
      "<leader>tn",
      function()
        vim.opt.number = not vim.opt.number:get()
        print("Line numbers " .. (vim.opt.number:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle line numbers"
    },
    {
      "<leader>tr",
      function()
        vim.opt.relativenumber = not vim.opt.relativenumber:get()
        print("Relative numbers " .. (vim.opt.relativenumber:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle relative numbers"
    },
    {
      "<leader>ts",
      function()
        vim.opt.spell = not vim.opt.spell:get()
        print("Spell check " .. (vim.opt.spell:get() and "enabled" or "disabled"))
      end,
      desc = "Toggle spell check"
    },
  },
})
