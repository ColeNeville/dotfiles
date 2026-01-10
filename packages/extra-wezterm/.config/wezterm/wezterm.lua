function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 14

config.color_scheme = "GruvboxDark"

-- In my workflow multiplexing will be handled by tmux
config.hide_tab_bar_if_only_one_tab = true

local local_config = wezterm.config_dir .. "/local_config.lua"

-- Load local overrides if present
if file_exists(local_config) then
  local local_config = dofile(local_config)
  wezterm.log_info(local_config)

  for k, v in pairs(local_config) do
    config[k] = v
  end
end

return config
