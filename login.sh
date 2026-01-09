#!/bin/bash

# Arguments:
#   $1: The PID of the application process.
#   $2: The target workspace number.
move_to_workspace_monitor() {
    local pid=$1
    local workspace=$2
    local preferedMonitor=$3
    local max_attempts=15 # Total attempts (15 * 0.2s = 3s timeout)
    local attempt=0

    while [ $attempt -lt $max_attempts ]; do
        if hyprctl clients -j | jq -e --argjson pid "$pid" '.[] | select(.pid == $pid)' > /dev/null; then
            hyprctl dispatch movetoworkspace "$workspace,pid:$pid"
            sleep 0.01
            hyprctl dispatch moveworkspacetomonitor $workspace $preferedMonitor
            return 0
        fi
        sleep 0.2
        ((attempt++))
    done
    return 1 # Failure
}

alacritty &
move_to_workspace_monitor $! 10 0

slack &
move_to_workspace_monitor $! 3 1

alacritty &
move_to_workspace_monitor $! 1 1

zen-browser &
move_to_workspace_monitor $! 2 1

hyprctl dispatch workspace 10
hyprctl dispatch workspace 2
