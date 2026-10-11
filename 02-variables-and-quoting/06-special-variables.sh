#!/usr/bin/env bash
# 06-special-variables.sh - variables that bash sets for you.
#
# Try it with arguments:
#   bash 06-special-variables.sh apple "red banana" cherry

echo "\$0  script name          : $0"
echo "\$1  first argument       : ${1:-<none>}"
echo "\$2  second argument      : ${2:-<none>}"
echo "\$#  number of arguments  : $#"
echo "\$\$  this script's PID    : $$"

# "$@" expands to every argument as a separate, intact word.
echo "Arguments, one per line (using \"\$@\"):"
for arg in "$@"; do
  echo "  [$arg]"
done

# "$*" joins every argument into ONE string.
echo "All arguments as one string (using \"\$*\"): [$*]"

# $? is the exit status of the most recent command.
ls / >/dev/null
echo "\$? after a successful command : $?"

ls /definitely/not/here 2>/dev/null
echo "\$? after a failed command     : $?"

# $! is the process ID of the most recent background job.
sleep 1 &
echo "\$!  PID of background job : $!"
wait   # wait for the background job to finish

# Other variables bash maintains.
echo "\$RANDOM    : $RANDOM"
echo "\$SECONDS   : $SECONDS (seconds since this script started)"
echo "\$LINENO    : $LINENO (the current line number)"
echo "\$HOSTNAME  : $HOSTNAME"
echo "\$BASH_VERSION : $BASH_VERSION"

# Arguments past the ninth need braces: ${10}, ${11}, ...
