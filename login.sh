# !/bin/bash

hyprctl dispatch workspace 1
alacritty &
sleep 0.5
hyprctl dispatch workspace 2
chromium &
