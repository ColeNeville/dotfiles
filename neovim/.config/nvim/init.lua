-- neovim/.config/nvim/init.lua

-- Set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- Changed to comma

-- Delegate to the lazy setup
require("config.lazy")
