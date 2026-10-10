# 01 - Getting Started

What a shell script is, how to run one, and the platform quirks to know before
writing anything bigger.

## Concepts

- **Shell script:** a text file of commands the shell runs top to bottom.
- **Shebang:** the first line, `#!/usr/bin/env bash`, tells the system which
  interpreter runs the file. `env` finds `bash` on the `PATH`, which is more
  portable than hard-coding `/bin/bash`.
- **Running a script:**
  - `bash script.sh` runs it in a new Bash process. No executable bit needed.
  - `./script.sh` uses the shebang. Needs `chmod +x script.sh` first.
  - `source script.sh` (or `. script.sh`) runs it in the *current* shell, so
    its variables and `cd` calls affect your terminal.
- **Comments:** everything after `#` on a line is ignored.
- **Exit status:** every command returns a number. `0` means success,
  anything else means failure. `$?` holds the status of the last command.

## Scripts

| Script | Shows |
|--------|-------|
| `01-hello-world.sh` | The smallest useful script |
| `02-shebang-and-running.sh` | Ways to run a script and what differs between them |
| `03-comments-and-structure.sh` | A sensible layout for a script |
| `04-detect-os.sh` | Telling Linux, WSL, Git Bash and macOS apart |
| `05-line-endings.sh` | Detecting and fixing CRLF line endings |

## Windows vs Linux

| Topic | Linux / WSL | Git Bash on Windows |
|-------|-------------|---------------------|
| Executable bit | `chmod +x` is required for `./script.sh` | `chmod` has almost no effect; a file with a shebang is treated as executable |
| Line endings | LF | Editors may save CRLF, which breaks scripts |
| Paths | `/home/you` | `/c/Users/you` (maps to `C:\Users\you`) |
| Home directory | `/home/you` | `/c/Users/you` |
| `uname -s` | `Linux` | `MINGW64_NT-...` |

**The CRLF error.** If a script was saved with Windows line endings you will
see errors like:

```
script.sh: line 2: $'\r': command not found
```

Fixes:

- In VS Code, click `CRLF` in the status bar and switch to `LF`.
- Convert a file: `sed -i 's/\r$//' script.sh` (or `dos2unix script.sh`).
- Stop Git converting on checkout: this repo's `.gitattributes` already does it.

**WSL tip.** Keep scripts inside the Linux filesystem (`~/...`) rather than
under `/mnt/c/...`. Files on `/mnt/c` are slower and permissions behave oddly.

## Exercises

1. Write a script that prints your username, the current directory, and today's date.
2. Run it three ways: `bash`, `./`, and `source`. What is different about `source`?
3. Add `exit 3` as the last line, run the script, then run `echo $?`.
4. Extend `04-detect-os.sh` to print the home directory path style for each OS.
