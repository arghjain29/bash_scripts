#!/usr/bin/env bash
# 01-echo-and-printf.sh - printing text.

# echo prints its arguments and adds a newline.
echo "Plain line"

# -n suppresses the trailing newline.
echo -n "No newline here... "
echo "continued on the same line."

# -e turns on backslash escapes (\n newline, \t tab).
echo -e "Column A\tColumn B\nRow 2A\tRow 2B"

# echo behaves differently between shells, and misbehaves if the text
# starts with a dash. printf is the reliable alternative.
#
# printf FORMAT ARGUMENTS...   (no newline unless you write \n)
printf "Hello, %s!\n" "World"

# Format specifiers:
#   %s string   %d integer   %f float   %x hex   %% a literal percent sign
printf "Name: %s, Age: %d, Score: %.1f%%\n" "Ada" 36 92.456

# Width and alignment make neat tables.
#   %-10s  left-aligned, 10 wide      %5d  right-aligned, 5 wide
printf "%-10s %5s %8s\n" "ITEM" "QTY" "PRICE"
printf "%-10s %5d %8.2f\n" "apple"  3  0.5
printf "%-10s %5d %8.2f\n" "melon"  1  2.75
printf "%-10s %5d %8.2f\n" "cherries" 120 12

# Zero padding, handy for file names.
printf "file-%03d.txt\n" 7

# The format is reused until the arguments run out.
printf "%s\n" "one" "two" "three"

# printf -v stores the result in a variable instead of printing it.
printf -v padded "%05d" 42
echo "Padded value: $padded"

# Colour with ANSI escape codes. \033[ starts a code, \033[0m resets.
red=$'\033[31m'
green=$'\033[32m'
bold=$'\033[1m'
reset=$'\033[0m'
printf "%sError:%s something failed\n" "$red" "$reset"
printf "%s%sOK:%s all good\n" "$bold" "$green" "$reset"

# Errors belong on stderr, so they can be separated from normal output.
echo "This is a warning sent to stderr" >&2
