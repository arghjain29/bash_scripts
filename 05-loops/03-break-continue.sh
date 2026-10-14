#!/usr/bin/env bash
# 03-break-continue.sh - controlling loop flow.

echo "--- continue: skip the rest of this iteration ---"
for n in {1..10}; do
  if (( n % 2 == 0 )); then
    continue          # skip even numbers
  fi
  printf "%d " "$n"
done
echo

echo "--- break: leave the loop early ---"
for n in {1..100}; do
  if (( n * n > 50 )); then
    echo "First number whose square is above 50: $n"
    break
  fi
done

echo "--- Search a list and stop at the first hit ---"
wanted="cherry"
found="no"
for fruit in apple banana cherry date elderberry; do
  echo "Checking $fruit"
  if [[ "$fruit" == "$wanted" ]]; then
    found="yes"
    break
  fi
done
echo "Found $wanted: $found"

echo "--- Skip unwanted items ---"
for file in notes.txt .hidden backup.bak report.txt; do
  case "$file" in
    .*)    continue ;;    # hidden files
    *.bak) continue ;;    # backups
  esac
  echo "Processing $file"
done

echo "--- break N: leave N levels of nested loops ---"
for outer in 1 2 3; do
  for inner in a b c; do
    if [[ "$outer" == "2" && "$inner" == "b" ]]; then
      echo "Hit 2b, leaving both loops"
      break 2
    fi
    echo "$outer$inner"
  done
done

echo "--- continue N: move on in an outer loop ---"
for outer in 1 2 3; do
  for inner in a b c; do
    if [[ "$inner" == "b" ]]; then
      continue 2      # go to the next value of 'outer'
    fi
    echo "$outer$inner"
  done
done
