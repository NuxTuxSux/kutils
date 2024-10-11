#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
tmux new-session -d -s jklserver "$SCRIPT_DIR/jkl.jl $1"
