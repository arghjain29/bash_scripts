#!/usr/bin/env bash
# 05-exit-codes-and-logic.sh - exit statuses and short-circuit operators.

# Every command finishes with an exit status from 0 to 255.
#   0        success ("true")
#   1-255    failure ("false"); the number can say what went wrong
# $? holds the status of the command that just ran.

true
echo "true  -> $?"

false
echo "false -> $?"

ls /definitely/not/here 2>/dev/null
echo "ls on a missing path -> $?"

# $? is overwritten by every command, so save it straight away if needed.
grep -q "nothing-matches-this-zzz" /dev/null
status=$?
echo "grep with no match -> $status"

echo "--- && and || ---"

# A && B : run B only if A succeeded.
mkdir -p /tmp && echo "mkdir worked, so this runs"

# A || B : run B only if A failed.
ls /definitely/not/here 2>/dev/null || echo "ls failed, so this runs"

# A common idiom: stop the script if a required step fails.
#   cd "$some_dir" || exit 1

# Pitfall: 'A && B || C' is NOT a real if/else.
# C also runs when A succeeds but B fails.
true && false || echo "This printed even though the first command succeeded"
# Use a proper if/else when both branches matter.

echo "--- Functions return exit statuses too ---"
is_even() {
  (( $1 % 2 == 0 ))   # the status of the last command becomes the return value
}

for n in 4 7; do
  if is_even "$n"; then
    echo "$n is even"
  else
    echo "$n is odd"
  fi
done

echo "--- Choosing your own exit codes ---"
# Conventional meanings:
#   0    success
#   1    general error
#   2    wrong usage (bad arguments)
#   126  command found but not executable
#   127  command not found
#   130  stopped by Ctrl+C (128 + signal number 2)

check_age() {
  local age="$1"
  if [[ ! "$age" =~ ^[0-9]+$ ]]; then
    return 2    # bad input
  elif (( age < 18 )); then
    return 1    # valid input, but the check failed
  fi
  return 0
}

for value in 30 12 abc; do
  check_age "$value"
  case $? in
    0) echo "$value: adult" ;;
    1) echo "$value: minor" ;;
    2) echo "$value: not a number" ;;
  esac
done

# The script itself exits with a status that callers can check.
exit 0
