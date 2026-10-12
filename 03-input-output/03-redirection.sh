#!/usr/bin/env bash
# 03-redirection.sh - sending output to files and input from files.

workdir="$(mktemp -d)"
echo "Working in: $workdir"

# >  writes stdout to a file, replacing any existing content.
echo "first line" > "$workdir/out.txt"

# >> appends instead of replacing.
echo "second line" >> "$workdir/out.txt"

echo "--- out.txt ---"
cat "$workdir/out.txt"

# 2> redirects stderr (file descriptor 2).
ls /definitely/not/here 2> "$workdir/err.txt"
echo "--- err.txt ---"
cat "$workdir/err.txt"

# Send stdout and stderr to different files.
ls / /definitely/not/here > "$workdir/good.txt" 2> "$workdir/bad.txt"
echo "good.txt has $(wc -l < "$workdir/good.txt") lines"
echo "bad.txt has  $(wc -l < "$workdir/bad.txt") lines"

# 2>&1 means "send stderr to wherever stdout currently goes".
# Order matters: redirect stdout first, then point stderr at it.
ls / /definitely/not/here > "$workdir/both.txt" 2>&1
echo "both.txt has $(wc -l < "$workdir/both.txt") lines"

# &> is a bash shortcut for the same thing.
ls / /definitely/not/here &> "$workdir/both2.txt"

# /dev/null discards whatever is written to it.
ls /definitely/not/here 2>/dev/null
echo "The error above was thrown away. Exit status was still: $?"

# Silence a command completely and only look at its exit status.
if command -v git >/dev/null 2>&1; then
  echo "git is installed"
else
  echo "git is not installed"
fi

# <  feeds a file to a command's stdin.
echo "Lines in out.txt: $(wc -l < "$workdir/out.txt")"

# >&2 sends a message to stderr.
echo "This message goes to stderr" >&2

# Redirect a whole group of commands at once with { }.
{
  echo "Report generated: $(date)"
  echo "Host: $(hostname)"
} > "$workdir/report.txt"
echo "--- report.txt ---"
cat "$workdir/report.txt"

# Custom file descriptors: open a file once, write to it many times.
exec 3> "$workdir/fd3.log"   # open fd 3 for writing
echo "line via fd 3" >&3
echo "another line"  >&3
exec 3>&-                    # close fd 3
echo "--- fd3.log ---"
cat "$workdir/fd3.log"

# Truncate a file to zero bytes without deleting it.
: > "$workdir/out.txt"
echo "out.txt is now $(wc -c < "$workdir/out.txt") bytes"

rm -rf "$workdir"
