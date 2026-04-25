#!/bin/bash

# Arguments:
#   $1: The PID of the application process.
#   $2: The target workspace number.
move_to_workspace_monitor() {
    local cmd=$1
    local workspace=$2
    local preferedMonitor=$3
    local max_attempts=150 # Total attempts (150 * 0.02s = 3s timeout)
    local attempt=0

    hyprctl dispatch workspace $workspace
    sleep 0.01
    $cmd &
    local pid=$!

    while [ $attempt -lt $max_attempts ]; do
        if hyprctl clients -j | jq -e --argjson pid "$pid" '.[] | select(.pid == $pid)' > /dev/null; then
            hyprctl dispatch movetoworkspace "$workspace,pid:$pid"
            sleep 0.01
            hyprctl dispatch moveworkspacetomonitor $workspace $preferedMonitor
            return 0
        fi
        sleep 0.02
        ((attempt++))
    done
    return 1 # Failure
}

move_to_workspace_monitor alacritty 10 0
move_to_workspace_monitor /usr/bin/slack 3 1
move_to_workspace_monitor alacritty 1 1
move_to_workspace_monitor zen-browser 2 1

hyprctl dispatch workspace 10
hyprctl dispatch workspace 2
