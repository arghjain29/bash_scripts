#!/usr/bin/env bash
# 04-pipes.sh - connecting commands with pipes.
#
# A pipe sends the stdout of the command on the left to the stdin of the
# command on the right. Small tools combine into bigger ones.

# Sample data used throughout.
fruits=$'banana\napple\ncherry\napple\nbanana\napple'

echo "--- Count lines ---"
echo "$fruits" | wc -l

echo "--- Sort ---"
echo "$fruits" | sort

echo "--- Unique values with counts, most common first ---"
# uniq only collapses ADJACENT duplicates, so sort first.
echo "$fruits" | sort | uniq -c | sort -rn

echo "--- Upper-case the two most common ---"
echo "$fruits" | sort | uniq -c | sort -rn | head -n 2 | tr '[:lower:]' '[:upper:]'

# Long pipelines read better with one stage per line.
# A line may end with | and continue on the next line.
echo "--- Same pipeline, formatted ---"
echo "$fruits" |
  sort |
  uniq -c |
  sort -rn |
  head -n 1

# Only stdout goes through a pipe. stderr still reaches the terminal.
echo "--- stderr bypasses the pipe ---"
ls /definitely/not/here | wc -l
# Use 2>&1 to send stderr through the pipe too (|& is a bash shortcut).
ls /definitely/not/here 2>&1 | wc -l

# tee writes its input to a file AND passes it along the pipe.
workdir="$(mktemp -d)"
echo "--- tee ---"
echo "$fruits" | sort -u | tee "$workdir/unique.txt" | wc -l
echo "Saved copy:"
cat "$workdir/unique.txt"
rm -rf "$workdir"

# The exit status of a pipeline is that of the LAST command only.
echo "--- Pipeline exit status ---"
false | true
echo "false | true          -> $?"

# PIPESTATUS holds the status of every stage of the last pipeline.
false | true
echo "PIPESTATUS            -> ${PIPESTATUS[*]}"

# 'set -o pipefail' makes a pipeline fail if ANY stage fails.
set -o pipefail
false | true
echo "with pipefail         -> $?"
set +o pipefail
