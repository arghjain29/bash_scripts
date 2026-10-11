#!/usr/bin/env bash
# 02-quoting.sh - double quotes, single quotes, and no quotes.

name="World"

# Double quotes: variables and $(commands) are expanded.
echo "Hello, $name"

# Single quotes: everything is literal.
echo 'Hello, $name'

# Backslash escapes one character inside double quotes.
echo "The variable is written as \$name and holds \"$name\""

# $'...' understands escape sequences such as \n and \t.
echo $'Line one\nLine two\tTabbed'

echo "--- Why unquoted variables are dangerous ---"

# 1. Word splitting: an unquoted value is split on spaces, tabs and newlines.
filename="my report.txt"

count_args() {
  echo "received $# argument(s)"
}

count_args $filename     # 2 arguments: "my" and "report.txt"
count_args "$filename"   # 1 argument : "my report.txt"

# 2. Globbing: an unquoted * is replaced by matching file names.
pattern="*"
echo "Unquoted:" $pattern    # lists the files in the current directory
echo "Quoted  : $pattern"    # prints a literal *

# 3. Empty values vanish when unquoted.
empty=""
count_args $empty      # 0 arguments
count_args "$empty"    # 1 argument (an empty string)

# 4. Whitespace is collapsed when unquoted.
spaced="a    b    c"
echo $spaced       # a b c
echo "$spaced"     # a    b    c

# Mixing quote styles: just put them next to each other.
echo 'Single-quoted part: $HOME -> '"$HOME"

# Rule of thumb: always "$quote" your variables.
