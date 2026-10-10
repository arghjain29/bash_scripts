#!/usr/bin/env bash
# 04-detect-os.sh - find out which platform the script is running on.
#
# Useful whenever a command or path differs between Linux and Windows.

# uname -s prints the kernel name:
#   Linux                -> Linux, and also WSL
#   Darwin               -> macOS
#   MINGW64_NT-10.0-...  -> Git Bash
#   MSYS_NT-...          -> MSYS2
#   CYGWIN_NT-...        -> Cygwin
detect_os() {
  case "$(uname -s)" in
    Linux*)
      # WSL reports "Linux", but its kernel version string mentions Microsoft.
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    Darwin*)        echo "macos" ;;
    MINGW* | MSYS*) echo "git-bash" ;;
    CYGWIN*)        echo "cygwin" ;;
    *)              echo "unknown" ;;
  esac
}

os="$(detect_os)"
echo "Detected platform: $os"
echo "Raw uname output : $(uname -s)"

# Branch on the result to pick platform-specific behaviour.
case "$os" in
  linux)    echo "Open a file with: xdg-open <file>" ;;
  wsl)      echo "Open a file with: explorer.exe <file>  (or wslview)" ;;
  git-bash) echo "Open a file with: start <file>" ;;
  macos)    echo "Open a file with: open <file>" ;;
  *)        echo "No known 'open' command for this platform." ;;
esac

# Bash also sets OSTYPE, which avoids running an external command.
echo "OSTYPE variable  : $OSTYPE"   # linux-gnu, msys, cygwin, darwin...
