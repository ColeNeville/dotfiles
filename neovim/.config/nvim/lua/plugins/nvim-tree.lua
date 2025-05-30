-- neovim/.config/nvim/lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- Pin to latest stable release
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For file icons (recommended for default experience)
  },
  config = function()
    -- Disable netrw, as nvim-tree will be the file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      git = {
        enable = true,
        ignore = false,
      },
    })
  end,
}
