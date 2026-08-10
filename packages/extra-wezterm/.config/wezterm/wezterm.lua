local wezterm = require "wezterm"
local config = wezterm.config_builder()

function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function load_overrides(dir)
  local handle = io.popen('ls "' .. dir .. '" 2>/dev/null | sort')
  if handle == nil then
    return
  end
  for filename in handle:lines() do
    if filename:match("%.lua$") then
      local filepath = dir .. "/" .. filename
      if file_exists(filepath) then
        local overrides = dofile(filepath)
        wezterm.log_info("Loaded override: " .. filename)
        for k, v in pairs(overrides) do
          config[k] = v
        end
      end
    end
  end
  handle:close()
end

config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 14

-- In my workflow multiplexing will be handled by tmux
config.hide_tab_bar_if_only_one_tab = true

-- Load package overrides from overrides.d/ in sorted order
local overrides_dir = wezterm.config_dir .. "/overrides.d"
if file_exists(overrides_dir) then
  load_overrides(overrides_dir)
end

-- Load local overrides (highest priority)
local local_config = wezterm.config_dir .. "/local_config.lua"
if file_exists(local_config) then
  local local_config = dofile(local_config)
  wezterm.log_info(local_config)

  for k, v in pairs(local_config) do
    config[k] = v
  end
end

return config
