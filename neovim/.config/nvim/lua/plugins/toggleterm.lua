return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local toggleterm = require('toggleterm')
    local Terminal = require('toggleterm.terminal').Terminal

    toggleterm.setup(opts)

    local lazygit_terminals = {}

    function _toggle_lazygit()
      local cwd = vim.fn.getcwd()

      if not lazygit_terminals[cwd] then
        lazygit_terminals[cwd] = Terminal:new({
          cmd = "lazygit",
          hidden = true,
          direction = "float",
        })
      end

      lazygit_terminals[cwd]:toggle()
    end
  end,
}
