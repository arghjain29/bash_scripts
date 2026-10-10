#!/usr/bin/env bash
# 02-shebang-and-running.sh - how a script gets run, and by what.
#
# The first line (the "shebang") names the interpreter.
#   #!/usr/bin/env bash   -> find bash on PATH (portable, preferred)
#   #!/bin/bash           -> fixed location (fails where bash lives elsewhere)
#   #!/bin/sh             -> POSIX shell, NOT bash; many bash features missing
#
# Three ways to run this file:
#   bash 02-shebang-and-running.sh     new process, shebang ignored
#   ./02-shebang-and-running.sh        new process, shebang used (needs chmod +x)
#   source 02-shebang-and-running.sh   runs inside your current shell

echo "Interpreter version : $BASH_VERSION"
echo "Script name (\$0)    : $0"
echo "Process ID (\$\$)     : $$"
echo "Parent process ID   : $PPID"

# BASH_SOURCE[0] is the file being read; $0 is the program that was started.
# They are equal when the script is executed, and differ when it is sourced.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "This script was EXECUTED (it runs in its own process)."
else
  echo "This script was SOURCED (it runs inside your current shell)."
fi

# A variable set here only survives in your terminal if the script was sourced.
DEMO_VARIABLE="set by 02-shebang-and-running.sh"
echo "DEMO_VARIABLE is now: $DEMO_VARIABLE"
echo "After this finishes, run:  echo \$DEMO_VARIABLE"
