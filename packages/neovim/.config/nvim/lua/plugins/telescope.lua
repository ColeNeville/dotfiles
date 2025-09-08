return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>pp", "<CMD>Telescope projects<CR>", desc = "Find Project" },
  },
  opts = function()
    local telescopeConfig = require("telescope.config")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    table.insert(vimgrep_arguments, "--hidden")

    return {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
  end,
}
