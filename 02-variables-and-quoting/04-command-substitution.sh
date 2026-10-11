#!/usr/bin/env bash
# 04-command-substitution.sh - capture a command's output in a variable.

# $(command) runs the command and is replaced by what it printed.
today="$(date +%Y-%m-%d)"
echo "Today is $today"

host="$(hostname)"
echo "Running on $host"

# It can be used directly inside a string.
echo "There are $(ls | wc -l) entries in $(pwd)"

# Substitutions can be nested without any escaping.
parent_name="$(basename "$(dirname "$PWD")")"
echo "Parent directory name: $parent_name"

# Trailing newlines are removed from the captured output.
# Inner newlines are kept, as long as you quote the variable.
listing="$(printf 'one\ntwo\nthree\n')"
echo "Quoted (newlines kept):"
echo "$listing"
echo "Unquoted (newlines become spaces):"
echo $listing

# A common use: timestamped file names.
backup_name="backup-$(date +%Y%m%d-%H%M%S).tar.gz"
echo "Backup file would be: $backup_name"

# The exit status of the substituted command is available in $?
# when the substitution is the whole assignment.
result="$(ls /definitely/not/here 2>/dev/null)"
echo "Exit status of the failed ls: $?"
echo "Captured output: '$result'"

# Old style uses backticks: `date`. It still works, but it is hard to
# nest and easy to misread. Prefer $( ).
