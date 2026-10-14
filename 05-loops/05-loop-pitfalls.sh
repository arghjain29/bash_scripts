#!/usr/bin/env bash
# 05-loop-pitfalls.sh - mistakes almost everyone makes once.

workdir="$(mktemp -d)"
touch "$workdir/plain.txt" "$workdir/my report.txt" "$workdir/data.csv"

echo "=== Pitfall 1: looping over the output of ls ==="
echo "Wrong: 'my report.txt' is split into two words"
for file in $(ls "$workdir"); do
  echo "  [$file]"
done

echo "Right: use a glob, which keeps each name intact"
for file in "$workdir"/*; do
  echo "  [$(basename "$file")]"
done

echo "=== Pitfall 2: a glob that matches nothing ==="
echo "By default the pattern itself is returned:"
for file in "$workdir"/*.pdf; do
  echo "  [$file]"
done

echo "Fix A: check that each item exists"
for file in "$workdir"/*.pdf; do
  [[ -e "$file" ]] || continue
  echo "  [$file]"
done
echo "  (nothing printed)"

echo "Fix B: nullglob makes an unmatched glob expand to nothing"
shopt -s nullglob
for file in "$workdir"/*.pdf; do
  echo "  [$file]"
done
echo "  (nothing printed)"
shopt -u nullglob

echo "=== Pitfall 3: variables changed in a piped loop are lost ==="
count=0
printf 'a\nb\nc\n' | while IFS= read -r line; do
  (( count++ ))
done
echo "Wrong: count after a piped loop = $count (each side of a pipe is a subshell)"

count=0
while IFS= read -r line; do
  (( count++ ))
done < <(printf 'a\nb\nc\n')
echo "Right: count with < <(...)      = $count"

echo "=== Pitfall 4: commands inside the loop eating its input ==="
printf 'one\ntwo\nthree\n' > "$workdir/list.txt"

echo "Wrong: 'cat' reads the rest of the file, so the loop runs once"
while IFS= read -r item; do
  echo "  item: $item"
  cat >/dev/null          # stands in for ssh, ffmpeg, etc.
done < "$workdir/list.txt"

echo "Right: give the inner command its own stdin"
while IFS= read -r item; do
  echo "  item: $item"
  cat >/dev/null </dev/null
done < "$workdir/list.txt"

echo "=== Pitfall 5: changing a list while looping over it ==="
echo "Collect first, then act. For example, gather names into an array"
echo "and only then rename or delete the files."

rm -rf "$workdir"
