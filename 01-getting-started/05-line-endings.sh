#!/usr/bin/env bash
# 05-line-endings.sh - detect and fix Windows (CRLF) line endings.
#
# Linux ends lines with LF (\n). Windows ends them with CRLF (\r\n).
# Bash treats the stray \r as part of the command, which gives errors like:
#     line 2: $'\r': command not found

# Work in a throwaway directory so nothing is left behind.
workdir="$(mktemp -d)"

# printf lets us write exact bytes, so we can create both kinds of file.
printf 'echo one\necho two\n'     > "$workdir/unix.sh"
printf 'echo one\r\necho two\r\n' > "$workdir/windows.sh"

# has_crlf FILE -> succeeds (exit 0) if the file contains a carriage return.
# $'\r' is Bash syntax for a literal carriage-return character.
has_crlf() {
  grep -q $'\r' "$1"
}

for file in "$workdir/unix.sh" "$workdir/windows.sh"; do
  if has_crlf "$file"; then
    echo "$(basename "$file"): CRLF line endings (will break in bash)"
  else
    echo "$(basename "$file"): LF line endings (good)"
  fi
done

# Fix: delete every carriage return and write the result to a new file.
tr -d '\r' < "$workdir/windows.sh" > "$workdir/fixed.sh"

if has_crlf "$workdir/fixed.sh"; then
  echo "fixed.sh: still has CRLF"
else
  echo "fixed.sh: converted to LF"
fi

# Other ways to do the same conversion in place:
#   sed -i 's/\r$//' script.sh
#   dos2unix script.sh

rm -rf "$workdir"
