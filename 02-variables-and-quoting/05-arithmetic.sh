#!/usr/bin/env bash
# 05-arithmetic.sh - integer maths in bash, and decimals with external tools.

a=17
b=5

# $(( expression )) evaluates integer arithmetic.
# Inside it, variables do not need a $.
echo "a + b  = $(( a + b ))"
echo "a - b  = $(( a - b ))"
echo "a * b  = $(( a * b ))"
echo "a / b  = $(( a / b ))   (integer division: the remainder is dropped)"
echo "a % b  = $(( a % b ))   (remainder)"
echo "a ** 2 = $(( a ** 2 ))  (power)"

# Store a result.
total=$(( a * b + 10 ))
echo "total = $total"

# (( )) without the $ runs arithmetic as a command, for updating variables.
count=0
(( count += 1 ))
(( count++ ))
echo "count = $count"

# (( )) also works as a true/false test.
if (( a > b )); then
  echo "$a is greater than $b"
fi

# Without $(( )), + is just text.
text=1+1
echo "Not arithmetic: $text"

# Other number bases.
echo "Hex 0xFF  = $(( 0xFF ))"
echo "Binary 101 = $(( 2#101 ))"
# Pitfall: a leading zero means octal, so 08 and 09 are errors.
# Force base 10 with 10#:
month="08"
echo "Month as a number: $(( 10#$month ))"

# Bash has no floating point. Use awk (available everywhere, including Git Bash).
echo "17 / 5 as a decimal = $(awk 'BEGIN { printf "%.2f", 17 / 5 }')"

# Passing shell variables into awk safely with -v.
ratio="$(awk -v x="$a" -v y="$b" 'BEGIN { printf "%.3f", x / y }')"
echo "ratio = $ratio"

# bc is the classic calculator, but it is not installed in Git Bash.
if command -v bc >/dev/null 2>&1; then
  echo "bc says: $(echo "scale=4; $a / $b" | bc)"
else
  echo "bc is not installed here (normal on Git Bash); awk covers it."
fi

# $RANDOM gives a pseudo-random integer from 0 to 32767.
echo "Dice roll: $(( RANDOM % 6 + 1 ))"
