-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Remove default Shift-H and Shift-L which are moving tabs
vim.keymap.del({ "n" }, "H")
vim.keymap.del({ "n" }, "L")

map({ "i", "n", "v" }, "<C-Left>", "<CMD>normal! b<CR>", { desc = "Previous word" })
map({ "i", "n", "v" }, "<C-Right>", "<CMD>normal! e<CR>", { desc = "Next word" })

map({ "n" }, "<C-Down>", "10<Down>")
map({ "n" }, "<C-Up>", "10<Up>")
map({ "n" }, "<C-,>", "<CMD>resize -2<CR>", { desc = "Shrink window" })
map({ "n" }, "<C-.>", "<CMD>resize +2<CR>", { desc = "Expand window" })
