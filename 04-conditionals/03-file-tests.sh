#!/usr/bin/env bash
# 03-file-tests.sh - checking files and directories.

workdir="$(mktemp -d)"

# Set up a few things to test against.
echo "some content" > "$workdir/notes.txt"
: > "$workdir/empty.txt"          # an empty file
mkdir "$workdir/subdir"

# describe PATH -> print what kind of thing the path is.
describe() {
  local path="$1"
  local label
  label="$(basename "$path")"

  if [[ ! -e "$path" ]]; then      # -e : exists (any type)
    echo "$label: does not exist"
  elif [[ -d "$path" ]]; then      # -d : is a directory
    echo "$label: directory"
  elif [[ -f "$path" ]]; then      # -f : is a regular file
    if [[ -s "$path" ]]; then      # -s : exists and is not empty
      echo "$label: file with content"
    else
      echo "$label: empty file"
    fi
  else
    echo "$label: something else (device, pipe, socket...)"
  fi
}

describe "$workdir/notes.txt"
describe "$workdir/empty.txt"
describe "$workdir/subdir"
describe "$workdir/missing.txt"

echo "--- Permission tests ---"
file="$workdir/notes.txt"
[[ -r "$file" ]] && echo "notes.txt is readable"
[[ -w "$file" ]] && echo "notes.txt is writable"
if [[ -x "$file" ]]; then
  echo "notes.txt is executable"
else
  echo "notes.txt is not executable"
fi

echo "--- Comparing files ---"
sleep 1
echo "newer" > "$workdir/newer.txt"
# -nt : newer than      -ot : older than
[[ "$workdir/newer.txt" -nt "$workdir/notes.txt" ]] && echo "newer.txt is newer than notes.txt"

echo "--- Typical real-world uses ---"

# Create a directory only if it is missing.
# (mkdir -p does this in one step and never fails if it already exists.)
if [[ ! -d "$workdir/logs" ]]; then
  mkdir "$workdir/logs"
  echo "Created logs directory"
fi

# Load a config file only if it exists.
config="$workdir/app.conf"
if [[ -f "$config" ]]; then
  echo "Loading $config"
else
  echo "No config file found, using defaults"
fi

# Refuse to overwrite an existing file.
target="$workdir/notes.txt"
if [[ -e "$target" ]]; then
  echo "Refusing to overwrite $(basename "$target")"
fi

rm -rf "$workdir"
