-- neovim/.config/nvim/lua/plugins/aider.lua
return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider", -- Lazy load on :Aider command or mapped keys
  keys = {
    {
      "<leader>Aa",
      "<cmd>Aider toggle<cr>",
      desc = "Toggle Aider (nvim-aider)",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send (nvim-aider)",
      mode = {"n", "v"},
    },
    {
      "<leader>Af",
      "<cmd>Aider add<cr>", -- Adds the current buffer's file
      desc = "Add file to context (nvim-aider)",
    },
    {
      "<leader>Ab",
      "<cmd>Aider buffer<cr>",
      desc = "Add buffer to context (nvim-aider)",
    },
    {
      "<leader>Ac",
      "<cmd>Aider command<cr>",
      desc = "Run command (nvim-aider)",
    },
    {
      "<leader>AR",
      "<cmd>Aider reset<cr>",
      desc = "Reset session (nvim-aider)",
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
