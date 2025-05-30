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
    
    -- No need to set up global anymore - keymaps will require the module directly
  end,
}
