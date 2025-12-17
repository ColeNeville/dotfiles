DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/setup"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/setup"

. "${DATA_DIR}/logging.sh"

# Create necessary directories
mkdir -p "${STATE_DIR}"

