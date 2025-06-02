return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    mode = { "n" },
    {
      "<leader>gg",
      function()
        require("utils.lazygit")
            .toggle_lazygit_float()
      end,
      desc = "Open Lazygit (ToggleTerm)",
    },
  },
  opts = {
    direction = "float", -- Global defaults can be set here
    float_opts = {
      border = "rounded",
    },
    -- close_on_exit = true,
  },
}
