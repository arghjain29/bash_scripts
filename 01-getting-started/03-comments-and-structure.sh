#!/usr/bin/env bash
# 03-comments-and-structure.sh - a sensible layout for any script.
#
# Description : Prints a short greeting report.
# Usage       : bash 03-comments-and-structure.sh
#
# A header like this one answers "what is this and how do I run it?"
# for the next person (often you, six months later).

# ---- 1. Configuration: constants at the top, in UPPER_CASE -----------------
GREETING="Welcome"
SEPARATOR="----------------------------------------"

# ---- 2. Functions: defined before they are used ----------------------------
print_header() {
  echo "$SEPARATOR"
  echo "$GREETING to Bash scripting"
  echo "$SEPARATOR"
}

print_info() {
  echo "Host : $(hostname)"   # a comment can follow a command on the same line
  echo "Shell: $BASH_VERSION"
}

# ---- 3. Main logic: kept at the bottom, short and readable -----------------
print_header
print_info

# Long commands can be split across lines with a trailing backslash.
echo "This is one command" \
     "written across" \
     "three lines."

# Several commands can share a line, separated by semicolons.
echo "first"; echo "second"

# There is no block-comment syntax in Bash. Use a # on every line.
