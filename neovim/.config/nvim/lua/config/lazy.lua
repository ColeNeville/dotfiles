-- neovim/.config/nvim/lua/config/lazy.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration (options, keymaps, etc.)
-- These are loaded before lazy.nvim setup.
require("config.options")
require("config.keymaps")

-- Setup lazy.nvim
-- "plugins" refers to lua/plugins.lua or lua/plugins/init.lua
require("lazy").setup("plugins", {
  -- You can add lazy.nvim options here, for example:
  -- checker = {
  --   enabled = true,
  --   notify = false, -- Don't notify on startup
  -- },
  -- change_detection = {
  --   notify = false, -- Don't notify on startup
  -- },
  ui = {
    -- If you are using a Nerd Font:
    -- icons = {
    --   cmd = "⌘",
    --   config = "🛠",
    --   event = "📅",
    --   ft = "📂",
    --   init = "⚙",
    --   keys = "🗝",
    --   plugin = "🔌",
    --   runtime = "💻",
    --   require = "🌙",
    --   source = "📄",
    --   start = "🚀",
    --   task = "📌",
    --   lazy = "💤 ",
    -- },
  },
})
