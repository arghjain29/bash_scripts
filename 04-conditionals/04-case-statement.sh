#!/usr/bin/env bash
# 04-case-statement.sh - matching one value against many patterns.
#
# Try: bash 04-case-statement.sh start
#      bash 04-case-statement.sh photo.JPG

# Shape of a case statement:
#
#   case VALUE in
#     PATTERN)  commands ;;
#     PATTERN | OTHER)  commands ;;
#     *)  default commands ;;
#   esac
#
# Patterns are globs (*, ?, [abc]), not regular expressions.
# The first matching pattern wins.

action="${1:-status}"

case "$action" in
  start)
    echo "Starting the service"
    ;;
  stop)
    echo "Stopping the service"
    ;;
  restart | reload)             # | means "or"
    echo "Restarting the service"
    ;;
  status)
    echo "Service status: unknown (this is only a demo)"
    ;;
  *.[jJ][pP][gG] | *.png)       # glob patterns work too
    echo "'$action' looks like an image file"
    ;;
  *)                            # * matches anything: the default branch
    echo "Unknown action: $action" >&2
    echo "Usage: $0 {start|stop|restart|status}" >&2
    ;;
esac

# Classify a single character.
classify() {
  case "$1" in
    # Character classes like [[:lower:]] behave the same in every locale;
    # ranges like [a-z] can also match uppercase letters in some locales.
    [[:digit:]]) echo "'$1' is a digit" ;;
    [[:lower:]]) echo "'$1' is a lowercase letter" ;;
    [[:upper:]]) echo "'$1' is an uppercase letter" ;;
    "")          echo "empty string" ;;
    ?)           echo "'$1' is some other single character" ;;
    *)           echo "'$1' is longer than one character" ;;
  esac
}

classify 7
classify q
classify Q
classify "#"
classify hello

# A yes/no answer, accepting several spellings.
confirm() {
  case "$1" in
    [yY] | [yY][eE][sS]) return 0 ;;
    *)                   return 1 ;;
  esac
}

for reply in y YES no maybe; do
  if confirm "$reply"; then
    echo "'$reply' means yes"
  else
    echo "'$reply' means no"
  fi
done
