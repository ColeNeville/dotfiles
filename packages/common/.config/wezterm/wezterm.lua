local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 11

config.color_scheme = "GruvboxDarkHard"

-- In my workflow multiplexing will be handled by tmux
config.hide_tab_bar_if_only_one_tab = true

-- Host specific configuration
local hostname = os.getenv("HOSTNAME")
if hostname == "garuda-v5" then
	config.enable_wayland = false
	config.font_size = 12
end

return config
