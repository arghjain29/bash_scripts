#!/usr/bin/env bash
# 02-while-until.sh - loops that run for as long as a condition holds.

echo "--- while: repeat while the condition is true ---"
count=1
while (( count <= 3 )); do
  echo "Count: $count"
  (( count++ ))
done

echo "--- until: repeat until the condition becomes true ---"
count=3
until (( count == 0 )); do
  echo "Countdown: $count"
  (( count-- ))
done

echo "--- while with a command as the condition ---"
# Create a file after two seconds, in the background.
workdir="$(mktemp -d)"
flag="$workdir/ready.flag"
( sleep 2; touch "$flag" ) &

# Poll until the file appears. A very common pattern for "wait until ready".
waited=0
while [[ ! -e "$flag" ]]; do
  echo "Waiting for the flag file... (${waited}s)"
  sleep 1
  (( waited++ ))
done
echo "Flag file appeared after about ${waited}s"
rm -rf "$workdir"

echo "--- Waiting with a timeout ---"
# Never wait forever. Give up after a fixed number of attempts.
attempts=0
max_attempts=3
until [[ -e /definitely/not/here ]]; do
  (( attempts++ ))
  if (( attempts >= max_attempts )); then
    echo "Gave up after $attempts attempts"
    break
  fi
  echo "Attempt $attempts failed, retrying"
  sleep 1
done

echo "--- Infinite loop with an explicit exit ---"
# 'while true' loops forever; something inside must break out.
n=0
while true; do
  (( n += 7 ))
  if (( n > 30 )); then
    echo "Stopped at $n"
    break
  fi
done

echo "--- Doubling until a limit ---"
value=1
while (( value < 100 )); do
  printf "%d " "$value"
  (( value *= 2 ))
done
echo
