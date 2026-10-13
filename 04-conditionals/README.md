# 04 - Conditionals

Making decisions: `if`, tests, `case`, and the exit codes they are built on.

## Concepts

- **`if` runs a command and checks its exit status.** `0` is true, anything
  else is false. `[ ... ]` and `[[ ... ]]` are just commands that return 0 or 1.
- **`[ ]` vs `[[ ]]`:**

  | | `[ ]` (POSIX `test`) | `[[ ]]` (bash keyword) |
  |-|----------------------|------------------------|
  | Unquoted variables | Break on spaces/empty | Safe |
  | `&&`, `\|\|` inside | No (use `-a`, `-o`) | Yes |
  | Pattern match `==` with `*` | No | Yes |
  | Regex `=~` | No | Yes |
  | Works in `sh` | Yes | No |

  **In bash scripts, prefer `[[ ]]`.**

- **Operators:**

  | Kind | Operators |
  |------|-----------|
  | String | `==`, `!=`, `<`, `>`, `-z` (empty), `-n` (not empty) |
  | Integer | `-eq`, `-ne`, `-lt`, `-le`, `-gt`, `-ge` |
  | File | `-e` exists, `-f` file, `-d` directory, `-r`/`-w`/`-x` permissions, `-s` not empty, `-L` symlink |
  | Logic | `!`, `&&`, `\|\|` |

  For numbers, `(( a > b ))` is clearer than `[[ $a -gt $b ]]`.

- **`case`** matches one value against several glob patterns. Cleaner than a
  long `if/elif` chain.
- **Short-circuit:** `cmd1 && cmd2` runs `cmd2` only if `cmd1` succeeded;
  `cmd1 || cmd2` runs `cmd2` only if `cmd1` failed.

## Scripts

| Script | Shows |
|--------|-------|
| `01-if-else.sh` | `if`, `elif`, `else`, using commands as conditions |
| `02-test-operators.sh` | String and number comparisons, `[ ]` vs `[[ ]]`, regex |
| `03-file-tests.sh` | Checking files, directories and permissions |
| `04-case-statement.sh` | Pattern matching with `case` |
| `05-exit-codes-and-logic.sh` | Exit statuses, `&&`, `\|\|`, `!` |

## Windows vs Linux

| Topic | Linux / WSL | Git Bash on Windows |
|-------|-------------|---------------------|
| `-x` (executable) test | Checks the permission bit | True for `.exe`, `.bat` and files starting with a shebang, regardless of `chmod` |
| File name case | `File.txt` and `file.txt` are different | Same file. `[[ -f FILE.TXT ]]` is true if `file.txt` exists |
| `-L` (symlink) test | Works | Symlinks are usually copies in Git Bash, so this is false |
| `-r` / `-w` tests | Follow Unix permissions | Based on Windows ACLs and the read-only attribute; less precise |
| String comparison | Case-sensitive | Case-sensitive (bash rules, not Windows rules) |

## Exercises

1. Write a script that takes a number and prints whether it is positive,
   negative or zero.
2. Take a file path argument; print whether it is a file, a directory, or missing.
3. Use `case` to map a file extension to a description (`.sh`, `.txt`, `.jpg`, other).
4. Check whether `git`, `curl` and `jq` are installed and report on each.
5. Validate that an argument looks like an email address using `=~`.
