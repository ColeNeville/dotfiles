set -euo pipefail

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/setup"

VALID_UV_INSTALL_CHECKSUM="e27424708d1ac59cfc94e3f540a111f2edbb37bc8164febce8ee7fa5d5505c71"

. "${DATA_DIR}/logging.sh"

python3 -m venv "${NERVE_DATA_DIR}/venv"
source "${NERVE_DATA_DIR}/venv/bin/activate"
pip install --upgrade pip
pip install nerve-adk
deactivate

python3 -m venv "${CHAINLIT_DATA_DIR}/venv"
source "${CHAINLIT_DATA_DIR}/venv/bin/activate"
pip install --upgrade pip
pip install chainlit
deactivate

mkdir -p "${DATA_DIR}/downloads"
cd "${DATA_DIR}/downloads"
wget -qO- https://astral.sh/uv/install.sh > uv-install.sh
log_info "SHA 256 checksum: $(sha256sum uv-install.sh | awk '{print $1}')"

if [ "$(sha256sum uv-install.sh | awk '{print $1}')" != "$VALID_UV_INSTALL_CHECKSUM" ]; then
    log_error "Invalid checksum for uv install script. Aborting installation."
    log_error "Expected: $VALID_UV_INSTALL_CHECKSUM"
    log_error "Got: $(sha256sum uv-install.sh | awk '{print $1}')"
    exit 1
fi

chmod +x uv-install.sh
./uv-install.sh
