# 02 - Variables and Quoting

Variables hold data. Quoting decides how the shell interprets that data.
Getting quoting right prevents most beginner bugs.

## Concepts

- **Assignment:** `name="value"` with **no spaces** around `=`.
  `name = "value"` tries to run a command called `name`.
- **Reading:** `$name` or `${name}`. Braces are needed when text follows
  directly: `${file}_backup`.
- **Everything is a string.** Bash has no types by default; arithmetic is done
  explicitly with `$(( ))`.
- **Quoting:**

  | Form | Variables expanded? | Word splitting / globbing? | Use for |
  |------|---------------------|----------------------------|---------|
  | `"double"` | Yes | No | Almost everything |
  | `'single'` | No | No | Literal text, regex, `awk`/`sed` programs |
  | unquoted | Yes | **Yes** | Rarely; only when you want splitting |

  **Rule of thumb: always write `"$var"`, never bare `$var`.**

- **Environment variables** are inherited by child processes. `export NAME`
  turns a shell variable into an environment variable.
- **Command substitution:** `$(command)` is replaced by the command's output.
- **Arithmetic:** `$(( 2 + 3 ))` is integer-only. Use `bc` or `awk` for decimals.
- **Special variables:** `$0`, `$1`..`$9`, `$#`, `$@`, `$?`, `$$`, `$!`.

## Scripts

| Script | Shows |
|--------|-------|
| `01-variables.sh` | Assigning, reading, `readonly`, `unset` |
| `02-quoting.sh` | Double vs single vs no quotes, and the bugs unquoted variables cause |
| `03-environment-variables.sh` | `export`, child processes, common env vars |
| `04-command-substitution.sh` | Capturing command output |
| `05-arithmetic.sh` | Integer maths, increments, decimals with `bc`/`awk` |
| `06-special-variables.sh` | `$0`, `$#`, `$@`, `$?`, `$$` and friends |

## Windows vs Linux

| Topic | Linux / WSL | Git Bash on Windows |
|-------|-------------|---------------------|
| User name variable | `$USER` | `$USERNAME` is always set; `$USER` may not be. `whoami` works on both |
| Home | `$HOME` = `/home/you` | `$HOME` = `/c/Users/you`; Windows also has `$USERPROFILE` (`C:\Users\you`) |
| `PATH` separator | `:` | `:` inside Git Bash (it converts Windows' `;` for you) |
| Windows env vars | Not present (WSL exposes only some) | All visible, e.g. `$APPDATA`, `$PROGRAMFILES`, `$TEMP` |
| Variable names | Case-sensitive | Case-sensitive in Bash, even though Windows itself is not |
| `bc` | Usually installed | **Not included.** Use `awk` for decimal maths |

Windows paths in variables contain backslashes and often spaces
(`C:\Program Files`), which makes quoting even more important.

## Exercises

1. Create variables for your name and age, then print a sentence using both.
2. Set `file="my report.txt"`. Run `touch $file` and `touch "$file"` in a temp
   directory. How many files does each create, and why?
3. Compute the number of seconds in a week with `$(( ))`.
4. Print the number of files in the current directory using command substitution.
5. Write a script that prints how many arguments it received and what they were.
