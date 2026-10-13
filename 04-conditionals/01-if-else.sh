#!/usr/bin/env bash
# 01-if-else.sh - the if statement.
#
# Try: bash 01-if-else.sh 42

# Shape of an if statement:
#
#   if CONDITION; then
#     ...
#   elif OTHER_CONDITION; then
#     ...
#   else
#     ...
#   fi

number="${1:-7}"   # use the first argument, or 7 if none was given

if (( number > 0 )); then
  echo "$number is positive"
elif (( number < 0 )); then
  echo "$number is negative"
else
  echo "$number is zero"
fi

# Strings are compared inside [[ ]].
# The spaces after [[ and before ]] are required.
answer="yes"
if [[ "$answer" == "yes" ]]; then
  echo "The answer is yes"
fi

# The condition is really just a command. 'if' runs it and checks
# whether it succeeded (exit status 0).
if grep -q "bash" "$0"; then
  echo "This script mentions bash"
fi

if command -v git >/dev/null 2>&1; then
  echo "git is available"
else
  echo "git is not installed"
fi

# ! inverts a condition.
if ! command -v some-tool-that-does-not-exist >/dev/null 2>&1; then
  echo "some-tool-that-does-not-exist is missing, as expected"
fi

# Combine conditions with && (and) and || (or).
age=25
if (( age >= 18 && age < 65 )); then
  echo "Working age"
fi

day="$(date +%u)"   # 1 = Monday ... 7 = Sunday
if [[ "$day" == "6" || "$day" == "7" ]]; then
  echo "It is the weekend"
else
  echo "It is a weekday"
fi

# if statements can be nested.
if [[ -n "$HOME" ]]; then
  if [[ -d "$HOME" ]]; then
    echo "HOME is set and is a directory"
  fi
fi
