#!/usr/bin/env bash
# 02-reading-input.sh - reading input from the user.
#
# This script is interactive: run it in a terminal and answer the prompts.

# read -r   : do not treat backslashes as escape characters (always use it)
# read -p   : show a prompt
read -r -p "What is your name? " name
echo "Hello, $name!"

# Provide a default when the user just presses Enter.
read -r -p "Favourite language [bash]: " language
language="${language:-bash}"
echo "Language: $language"

# Read several words into several variables.
# Extra words all go into the last variable.
read -r -p "Enter first and last name: " first last
echo "First: $first | Last: $last"

# -s hides what is typed (for passwords). Print a newline afterwards.
read -r -s -p "Enter a secret (it will not be shown): " secret
echo
echo "Your secret has ${#secret} characters."

# -t sets a timeout in seconds. read fails if time runs out.
if read -r -t 5 -p "Quick! Type something within 5 seconds: " quick; then
  echo "You typed: $quick"
else
  echo
  echo "Too slow."
fi

# -n 1 returns after a single key press, without waiting for Enter.
read -r -n 1 -p "Continue? [y/n] " answer
echo
case "$answer" in
  y | Y) echo "Continuing." ;;
  *)     echo "Stopping." ;;
esac

# Validate input in a loop until it is acceptable.
while true; do
  read -r -p "Enter a number between 1 and 10: " number
  if [[ "$number" =~ ^[0-9]+$ ]] && (( number >= 1 && number <= 10 )); then
    break
  fi
  echo "Not valid, try again."
done
echo "Thanks, you chose $number."

# read also works on piped input, not only the keyboard:
#   echo "piped text" | bash -c 'read -r line; echo "got: $line"'
