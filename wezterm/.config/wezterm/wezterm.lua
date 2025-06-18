local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.font_size = 12

config.color_scheme = "Gruvbox dark, hard (base16)"

config.enable_wayland = false

config.hide_tab_bar_if_only_one_tab = true

return config
