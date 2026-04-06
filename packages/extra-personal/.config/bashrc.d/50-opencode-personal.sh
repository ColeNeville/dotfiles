# Personal OpenCode config
# This config extends the base config in ~/.config/opencode/opencode.json
# via OpenCode's config merging feature
if [ -d "$HOME/.config/opencode-personal" ]; then
	export OPENCODE_CONFIG="$HOME/.config/opencode-personal/opencode.json"
fi
