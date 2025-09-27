#!/bin/bash

# Arguments:
#   $1: The PID of the application process.
#   $2: The target workspace number.
move_to_workspace() {
    local pid=$1
    local workspace=$2
    local max_attempts=15 # Total attempts (15 * 0.2s = 3s timeout)
    local attempt=0

    while [ $attempt -lt $max_attempts ]; do
        if hyprctl clients -j | jq -e --argjson pid "$pid" '.[] | select(.pid == $pid)' > /dev/null; then
            # The window was found.
            # Now we dispatch the command to move that specific window to the target workspace.
            hyprctl dispatch movetoworkspace "$workspace,pid:$pid"
            sleep 0.01
            echo "Successfully moved PID $pid to workspace $workspace."
            return 0 # Success
        fi

        sleep 0.2
        ((attempt++))
    done

    echo "Warning: Timed out waiting for window with PID $pid."
    return 1 # Failure
}

thunderbird &
move_to_workspace $! 9

slack &
move_to_workspace $! 3

alacritty &
move_to_workspace $! 1

chromium &
move_to_workspace $! 2

