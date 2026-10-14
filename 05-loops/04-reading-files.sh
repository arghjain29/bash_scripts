#!/usr/bin/env bash
# 04-reading-files.sh - reading files and command output line by line.

workdir="$(mktemp -d)"

# A sample file. Note the leading spaces and the backslash.
cat > "$workdir/lines.txt" <<'EOF'
first line
   indented line
path\with\backslashes
last line
EOF

echo "--- The standard idiom ---"
# IFS=   keep leading/trailing whitespace
# -r     keep backslashes as they are
# < file after 'done' feeds the file to the whole loop
line_number=0
while IFS= read -r line; do
  (( line_number++ ))
  printf "%2d: [%s]\n" "$line_number" "$line"
done < "$workdir/lines.txt"

echo "--- A file whose last line has no trailing newline ---"
printf 'alpha\nbeta\ngamma' > "$workdir/no-newline.txt"
# read fails on the final partial line but still fills the variable.
# The extra test stops that last line from being dropped.
while IFS= read -r line || [[ -n "$line" ]]; do
  echo "Line: $line"
done < "$workdir/no-newline.txt"

echo "--- Splitting each line into fields ---"
cat > "$workdir/people.csv" <<'EOF'
name,age,city
Ada,36,London
Linus,54,Portland
Grace,85,New York
EOF

# Setting IFS just for the read command splits on commas.
# The braces let us read (and discard) the header line first.
{
  read -r header
  echo "Header was: $header"
  while IFS=, read -r name age city; do
    echo "$name is $age and lives in $city"
  done
} < "$workdir/people.csv"

echo "--- Handling Windows (CRLF) files ---"
printf 'one\r\ntwo\r\n' > "$workdir/windows.txt"
while IFS= read -r line; do
  line="${line%$'\r'}"      # remove a trailing carriage return if present
  echo "Clean line: [$line]"
done < "$workdir/windows.txt"

echo "--- Reading the output of a command ---"
# < <(command) feeds a command's output to the loop. Unlike a pipe, the
# loop runs in the current shell, so variables set inside it survive.
total=0
while IFS= read -r line; do
  (( total += ${#line} ))
done < <(cat "$workdir/lines.txt")
echo "Total characters: $total"

echo "--- Reading a whole file into an array (bash 4+) ---"
mapfile -t all_lines < "$workdir/lines.txt"
echo "The file has ${#all_lines[@]} lines"
echo "The last one is: ${all_lines[-1]}"

rm -rf "$workdir"
