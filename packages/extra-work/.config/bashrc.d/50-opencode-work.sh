# Work OpenCode config
# This config extends the base config in ~/.config/opencode/opencode.json
# via OpenCode's config merging feature
if [ -d "$HOME/.config/opencode-work" ]; then
	export OPENCODE_CONFIG="$HOME/.config/opencode-work/opencode.json"
fi
