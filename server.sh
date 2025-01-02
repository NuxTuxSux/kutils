#!/usr/bin/env bash
tmux new-session -d -s jklserver "./jkl.jl $1"
