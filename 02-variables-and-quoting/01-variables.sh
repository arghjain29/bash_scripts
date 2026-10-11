#!/usr/bin/env bash
# 01-variables.sh - creating and using variables.

# Assignment: no spaces around the equals sign.
name="Ada"
age=36
city="London"

# Reading: put a $ in front. Use it inside double quotes.
echo "Name: $name"
echo "Age : $age"

# Braces mark where the variable name ends.
fruit="apple"
echo "I have three ${fruit}s"   # without braces bash looks for $fruits
echo "Without braces: $fruits (empty, because \$fruits does not exist)"

# Reassigning just overwrites the old value.
city="Paris"
echo "City: $city"

# A variable can be built from other variables.
greeting="Hello, $name from $city"
echo "$greeting"

# readonly makes a constant. Assigning to it again is an error.
readonly MAX_RETRIES=3
echo "Max retries: $MAX_RETRIES"
# MAX_RETRIES=5    # uncomment to see: "MAX_RETRIES: readonly variable"

# unset removes a variable entirely.
temp="short lived"
unset temp
echo "After unset, temp is: '${temp}'"

# An unset variable expands to an empty string, silently.
# That hides typos. Chapter 11 shows how 'set -u' turns this into an error.
echo "Typo example: '$nmae'"

# Naming convention:
#   UPPER_CASE  for constants and environment variables
#   lower_case  for ordinary script variables
