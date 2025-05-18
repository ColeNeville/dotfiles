#!/bin/bash

restart_gpg_agent () {
  gpgconf --kill gpg-agent
  gpgconf --launch gpg-agent

  sudo systemctl restart pcscd
}
