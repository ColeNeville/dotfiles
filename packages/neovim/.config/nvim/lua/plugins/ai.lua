-- neovim/.config/nvim/lua/plugins/aider.lua
return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider", -- Lazy load on :Aider command or mapped keys
  keys = {
    mode = { "n" },
    {
      "<leader>Aa",
      "<cmd>Aider toggle<cr>",
      desc = "Toggle panel (Aider)",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send selection/buffer (Aider)",
      mode = { "n", "v" },
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
  dependencies = {
    "folke/snacks.nvim",
    "nvim-tree/nvim-tree.lua",
  },
  opts = {
    auto_reload = true,
    args = {
      "--auto-commits",
      "--pretty",
      "--stream",
    },
  },
  config = function(_, opts)
    require("nvim_aider").setup(opts)
  end,
}
