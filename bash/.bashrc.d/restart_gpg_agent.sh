#!/bin/bash

restart_gpg_agent () {
  sudo systemctl restart pcscd
}
