#!/bin/bash

# Check if all arguments are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <session_name> <command> <sleep_sec>"
    exit 1
fi

SESSION=$1
COMMAND=$2
SLEEP_SEC=$3

# Check if the tmux session exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Error: tmux session '$SESSION' does not exist."
    exit 1
fi

# Use window IDs (e.g. @5) not indices: IDs are stable and never renumbered,
# so closing an earlier window won't shift the targets out from under us.
tmux list-windows -t "$SESSION" -F "#{window_id}" | while read -r win; do
    # Skip windows that have since been closed.
    if ! tmux list-windows -t "$SESSION" -F "#{window_id}" | grep -qx "$win"; then
        echo "skipping $win (no longer exists)"
        continue
    fi
    echo "sending to $win"
    tmux send-keys -t "$win" "$COMMAND" C-m
    echo "sleeping $SLEEP_SEC"
    sleep "$SLEEP_SEC"
done
