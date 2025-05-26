-- neovim/.config/nvim/lua/plugins/aider.lua
return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider", -- Lazy load on :Aider command or mapped keys
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
