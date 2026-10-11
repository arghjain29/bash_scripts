#!/usr/bin/env bash
# 03-environment-variables.sh - shell variables vs environment variables.
#
# A shell variable exists only in the current shell.
# An environment variable is also passed to every child process.

echo "--- Common environment variables ---"
echo "HOME  : $HOME"
echo "PWD   : $PWD"
echo "SHELL : ${SHELL:-not set}"
echo "LANG  : ${LANG:-not set}"
# USER is standard on Linux; Git Bash reliably sets USERNAME instead.
echo "User  : ${USER:-${USERNAME:-unknown}}"

# PATH is the list of directories searched for commands, separated by colons.
echo "First three PATH entries:"
echo "$PATH" | tr ':' '\n' | head -n 3

echo "--- Shell variable vs exported variable ---"
local_only="I stay in this shell"
export SHARED="I am passed to children"

# bash -c starts a child process. Single quotes stop THIS shell from
# expanding the variables, so the child does the expanding.
bash -c 'echo "child sees local_only: [${local_only:-}]"'
bash -c 'echo "child sees SHARED    : [${SHARED:-}]"'

echo "--- Setting a variable for one command only ---"
# VAR=value command   sets VAR just for that command's environment.
GREETING="hi there" bash -c 'echo "child sees GREETING: [$GREETING]"'
echo "parent sees GREETING: [${GREETING:-}]"

echo "--- A child cannot change its parent ---"
counter=1
bash -c 'counter=99'
echo "counter is still: $counter"

# Useful commands:
#   env            list all environment variables
#   export -p      list exported variables in re-usable form
#   unset NAME     remove a variable
#
# To make a variable permanent, add an export line to ~/.bashrc
# (on Git Bash: ~/.bashrc or ~/.bash_profile under C:\Users\<you>).
