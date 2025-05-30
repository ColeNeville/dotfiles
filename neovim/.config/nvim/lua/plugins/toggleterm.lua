return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float", -- Global defaults can be set here
    float_opts = {
      border = "rounded",
    },
    -- close_on_exit = true,
  },
  config = function(_, opts)
    local toggleterm_module = require('toggleterm')
    toggleterm_module.setup(opts)

    -- Set up lazygit functionality
    local lazygit = require('utils.lazygit')
    _G.toggle_lazygit_float = lazygit.toggle_lazygit_float
  end,
}
