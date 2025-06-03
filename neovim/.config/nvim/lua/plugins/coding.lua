return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "jsonc" })
    end,
  },
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    cmd = {
      "DevcontainerAttach",
      "DevcontainerStart",
      "DevcontainerStop",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
