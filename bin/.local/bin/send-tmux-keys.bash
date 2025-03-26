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

tmux list-windows -t $SESSION -F "#{window_index}" | while read win; do
    echo "sending to $SESSION:$win"
    tmux send-keys -t $SESSION:$win "$COMMAND" C-m
    echo "sleeping $SLEEP_SEC"
    sleep $SLEEP_SEC
done
