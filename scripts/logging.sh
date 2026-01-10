#!/bin/bash

LOG_LEVEL="${LOG_LEVEL:-info}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

LOG_DEBUG_VALUE="0"
LOG_INFO_VALUE="1"
LOG_WARN_VALUE="2"
LOG_ERROR_VALUE="3"

map_log_level_to_value() {
  case "$1" in
  debug) echo "$LOG_DEBUG_VALUE" ;;
  info) echo "$LOG_INFO_VALUE" ;;
  warn) echo "$LOG_WARN_VALUE" ;;
  error) echo "$LOG_ERROR_VALUE" ;;
  *) echo "$LOG_INFO_VALUE" ;; # Default to info
  esac
}

STOW_LOG_LEVEL_VALUE=$(map_log_level_to_value "$LOG_LEVEL")

echo "$STOW_LOG_LEVEL_VALUE"

# Logging functions
log_debug() {
  if [ "$STOW_LOG_LEVEL_VALUE" -le "$LOG_DEBUG_VALUE" ]; then
    echo -e "${BLUE}[DEBUG]${NC} $1"
  fi
}

log_info() {
  if [ "$STOW_LOG_LEVEL_VALUE" -le "$LOG_INFO_VALUE" ]; then
    echo -e "${GREEN}[INFO]${NC} $1"
  fi
}

log_warn() {
  if [ "$STOW_LOG_LEVEL_VALUE" -le "$LOG_WARN_VALUE" ]; then
    echo -e "${YELLOW}[WARN]${NC} $1"
  fi
}

log_error() {
  if [ "$STOW_LOG_LEVEL_VALUE" -le "$LOG_ERROR_VALUE" ]; then
    echo -e "${RED}[ERROR]${NC} $1"
  fi
}
