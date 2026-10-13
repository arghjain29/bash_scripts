#!/usr/bin/env bash
# 02-test-operators.sh - comparing strings and numbers.

echo "--- String tests ---"
a="apple"
b="banana"
empty=""

[[ "$a" == "$a" ]] && echo "'$a' equals '$a'"
[[ "$a" != "$b" ]] && echo "'$a' is different from '$b'"
[[ "$a" < "$b" ]]  && echo "'$a' sorts before '$b'"
[[ -z "$empty" ]]  && echo "empty is empty      (-z: zero length)"
[[ -n "$a" ]]      && echo "a is not empty      (-n: non-zero length)"

echo "--- Number tests ---"
x=10
y=20

# Inside [[ ]], numbers need the -eq family of operators...
[[ "$x" -lt "$y" ]] && echo "$x is less than $y (using -lt)"

# ...but (( )) reads far more naturally.
(( x < y ))  && echo "$x is less than $y (using (( )))"
(( x != y )) && echo "$x is not equal to $y"

# Pitfall: < and > inside [[ ]] compare as TEXT, not as numbers.
if [[ 9 > 10 ]]; then
  echo "As text, '9' sorts after '10'. Use (( )) or -gt for numbers."
fi

echo "--- Pattern matching (bash [[ ]] only) ---"
file="report-2026.csv"

# With ==, an UNQUOTED right-hand side is a glob pattern.
[[ "$file" == *.csv ]]    && echo "$file ends in .csv"
[[ "$file" == report-* ]] && echo "$file starts with report-"
# Quoted, it is a literal string.
[[ "$file" == "*.csv" ]]  || echo "$file is not literally '*.csv'"

echo "--- Regular expressions with =~ ---"
# Keep the regex unquoted (or in a variable); quoting makes it literal.
if [[ "$file" =~ ^report-([0-9]{4})\.csv$ ]]; then
  # BASH_REMATCH[0] is the whole match, [1] the first ( ) group.
  echo "Year extracted from the name: ${BASH_REMATCH[1]}"
fi

input="12345"
[[ "$input" =~ ^[0-9]+$ ]] && echo "'$input' is made only of digits"

echo "--- Why [[ ]] is safer than [ ] ---"
spaced="two words"

# With [ ], an unquoted variable is split into several arguments and
# the test breaks. Errors are hidden here so the script carries on.
if [ $spaced == "two words" ] 2>/dev/null; then
  echo "[ ] with an unquoted variable: matched"
else
  echo "[ ] with an unquoted variable: broke ('too many arguments')"
fi

# [[ ]] does not split variables, so it works either way.
if [[ $spaced == "two words" ]]; then
  echo "[[ ]] with an unquoted variable: works"
fi

# [ ] is still needed for scripts that must run under plain sh.
