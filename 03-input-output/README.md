# 03 - Input and Output

How scripts print, read, and connect commands together.

## Concepts

- **Three standard streams**, each with a file descriptor number:

  | Stream | FD | Default |
  |--------|----|---------|
  | stdin  | 0 | keyboard |
  | stdout | 1 | terminal (normal output) |
  | stderr | 2 | terminal (errors and diagnostics) |

- **`echo` vs `printf`:** `echo` is quick; `printf` is predictable and supports
  formatting. Prefer `printf` when output must be exact.
- **`read`** reads a line from stdin into variables. Always use `read -r` so
  backslashes are not mangled.
- **Redirection:**

  | Syntax | Meaning |
  |--------|---------|
  | `> file` | stdout to file, overwrite |
  | `>> file` | stdout to file, append |
  | `2> file` | stderr to file |
  | `> file 2>&1` | stdout and stderr to the same file |
  | `&> file` | same as above (bash only) |
  | `< file` | file becomes stdin |
  | `2>/dev/null` | throw errors away |

- **Pipes:** `a | b` sends stdout of `a` to stdin of `b`.
- **Here-document:** `<<EOF ... EOF` feeds a block of text to a command.
- **Here-string:** `<<< "text"` feeds one string to a command.

## Scripts

| Script | Shows |
|--------|-------|
| `01-echo-and-printf.sh` | Printing, escape sequences, formatted tables |
| `02-reading-input.sh` | Prompts, silent input, timeouts, defaults (interactive) |
| `03-redirection.sh` | Sending stdout/stderr to files, custom file descriptors |
| `04-pipes.sh` | Chaining commands, `tee`, pipeline exit status |
| `05-here-documents.sh` | Multi-line text, generating files, here-strings |

## Windows vs Linux

| Topic | Linux / WSL | Git Bash on Windows |
|-------|-------------|---------------------|
| Null device | `/dev/null` | `/dev/null` works in Git Bash. `NUL` is the cmd.exe name; do not use it in bash (it creates a file called `NUL`) |
| Line endings of output | LF | LF from bash tools; Windows programs you call (`ipconfig`, `systeminfo`) emit CRLF. Strip with `tr -d '\r'` |
| Reading files made in Notepad | n/a | May have CRLF and a UTF-8 BOM; `read` will leave a trailing `\r` on each line |
| Interactive prompts | Work normally | In Git Bash's mintty, some Windows console programs (`python`, `node` REPL) need a `winpty` prefix |
| Colours | ANSI codes work | Work in Git Bash and Windows Terminal |

## Exercises

1. Print a three-column table of names, ages and cities with `printf`.
2. Ask for a name and a favourite number, then print number times two.
3. Run `ls` on one existing and one missing path, sending stdout to `out.txt`
   and stderr to `err.txt`.
4. Using pipes, find the five most common words in any text file.
5. Use a here-document to generate a small HTML file with today's date in it.
