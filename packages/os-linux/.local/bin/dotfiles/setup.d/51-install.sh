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

download_dir="$(mktemp -d)"

mkdir -p "${download_dir}"

script_path="${download_dir}/uv-install.sh"

wget -qO- https://astral.sh/uv/install.sh > "${script_path}"
log_info "SHA 256 checksum: $(sha256sum "${script_path}" | awk '{print $1}')"

if [ "$(sha256sum ${script_path} | awk '{print $1}')" != "$VALID_UV_INSTALL_CHECKSUM" ]; then
    log_error "Invalid checksum for uv install script. Aborting installation."
    log_error "Expected: $VALID_UV_INSTALL_CHECKSUM"
    log_error "Got: $(sha256sum "${script_path}" | awk '{print $1}')"
    exit 1
fi

chmod +x "${script_path}"
"${script_path}"
