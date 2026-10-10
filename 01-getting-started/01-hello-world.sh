#!/usr/bin/env bash
# 01-hello-world.sh - the smallest useful script.
#
# Run it with:   bash 01-hello-world.sh

# echo prints its arguments followed by a newline.
echo "Hello, World!"

# Commands run one after another, top to bottom.
echo "Today is $(date)"
echo "You are logged in as: $(whoami)"
echo "Your current directory is: $PWD"

# A script ends with the exit status of its last command.
# You can also set it explicitly: 0 means success.
exit 0
