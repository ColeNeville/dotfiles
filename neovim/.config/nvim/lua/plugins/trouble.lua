return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
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
  },
  opts = {},
}
