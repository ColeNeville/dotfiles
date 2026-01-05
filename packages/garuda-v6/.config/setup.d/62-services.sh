set -eou pipefail

SYSTEMCTL_SERVICES=(
  "libvirtd.socket"
)

for service in "${SYSTEMCTL_SERVICES[@]}"; do
  if systemctl is-enabled "$service" &>/dev/null; then
    echo "$service is already enabled."
  else
    echo "Enabling and starting $service..."
    sudo systemctl enable --now "$service"
  fi
done
