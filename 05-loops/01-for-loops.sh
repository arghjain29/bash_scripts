#!/usr/bin/env bash
# 01-for-loops.sh - looping over lists, ranges and files.

echo "--- A list of words ---"
for colour in red green blue; do
  echo "Colour: $colour"
done

echo "--- A brace range ---"
for n in {1..5}; do
  echo "Number $n"
done

echo "--- A range with a step (start..end..step) ---"
for n in {0..20..5}; do
  echo "Step $n"
done

# Brace ranges are expanded before variables, so {1..$max} does not work.
# Use a C-style loop when the limits are in variables.
echo "--- C-style loop ---"
max=3
for (( i = 1; i <= max; i++ )); do
  echo "Iteration $i of $max"
done

echo "--- Counting down ---"
for (( i = 3; i > 0; i-- )); do
  echo "$i..."
done
echo "Lift off"

echo "--- Files matching a glob ---"
# The shell expands *.sh into the matching file names, each one intact
# even if it contains spaces.
for file in *.sh; do
  # If nothing matches, the pattern is left as the literal text "*.sh".
  [[ -e "$file" ]] || continue
  echo "Script: $file"
done

echo "--- Output of a command, one word at a time ---"
for word in $(echo "split on whitespace"); do
  echo "Word: $word"
done
# This splits on ANY whitespace, so it is only safe for simple words.
# See 04-reading-files.sh for reading lines properly.

echo "--- Script arguments ---"
# "$@" keeps each argument intact. 'for arg; do' is shorthand for the same.
for arg in "$@"; do
  echo "Argument: $arg"
done
(( $# == 0 )) && echo "(no arguments given; try passing some)"

echo "--- Elements of an array (covered in chapter 7) ---"
servers=("web-1" "web-2" "db primary")
for server in "${servers[@]}"; do
  echo "Server: $server"
done

echo "--- Nested loops ---"
for row in 1 2 3; do
  for col in a b; do
    printf "%s%s " "$row" "$col"
  done
  echo
done
