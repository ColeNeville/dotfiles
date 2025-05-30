-- neovim/.config/nvim/lua/config/keymaps/ai-assistant.lua
-- AI assistance tools keymaps (Aider)

local wk = require("which-key")

wk.add({
  { mode = { "n", "v" }, -- Normal and visual mode keymaps

    -- ================================================================
    -- AI ASSISTANCE (AIDER)
    -- ================================================================
    { "<leader>A", group = "AI Assistant (Aider)" },
    {
      "<leader>Aa",
      "<cmd>Aider toggle<cr>",
      desc = "Toggle panel (Aider)",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send selection/buffer (Aider)",
    },
    {
      "<leader>Af",
      "<cmd>Aider add<cr>",
      desc = "Add current file (Aider)",
    },
    {
      "<leader>Ab",
      "<cmd>Aider buffer<cr>",
      desc = "Add buffer content (Aider)",
    },
    {
      "<leader>Ac",
      "<cmd>Aider command<cr>",
      desc = "Run custom command (Aider)",
    },
    {
      "<leader>AR",
      "<cmd>Aider reset<cr>",
      desc = "Reset session (Aider)",
    },
  },
})
