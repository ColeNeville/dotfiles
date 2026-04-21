export PI_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pi"

# pi coding agent configuration
# pi uses PI_CODING_AGENT_DIR to determine the agent config directory
# This directory contains models.json, auth.json, settings.json
#
# By default: ~/.pi/agent
# With XDG: ~/.config/pi (matches pi's behavior with PI_CODING_AGENT_DIR)
#
# Note: PI_CODING_AGENT_DIR points to the directory that contains models.json,
# not a subdirectory. So if models.json is at ~/.config/pi/agent/models.json,
# then PI_CODING_AGENT_DIR should be ~/.config/pi/agent

export PI_CODING_AGENT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pi/agent"
