#!/usr/bin/env bash

killall -q polybar
polybar --config="~/.config/polybar/config.ini" 2>&1 | tee /tmp/polybar.log & disown
