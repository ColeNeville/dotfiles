#!/bin/bash

/usr/bin/polybar --reload 2>&1 | tee /tmp/polybar.log &

/usr/bin/rofi-polkit-agent &

/usr/bin/bauh-tray &
