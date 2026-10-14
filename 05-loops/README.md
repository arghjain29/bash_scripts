# 05 - Loops

Repeating work: over lists, ranges, files, and command output.

## Concepts

- **`for item in LIST`** runs once per word in the list.
- **`for (( i = 0; i < n; i++ ))`** is the C-style counting loop.
- **`while CONDITION`** repeats while the condition succeeds.
- **`until CONDITION`** repeats until the condition succeeds.
- **`break`** leaves the loop; **`continue`** skips to the next iteration.
- **Reading a file line by line** has one correct idiom:

  ```bash
  while IFS= read -r line; do
    echo "$line"
  done < file.txt
  ```

  - `IFS=` keeps leading and trailing whitespace.
  - `-r` keeps backslashes.
  - `< file.txt` after `done` feeds the file to the loop.

- **Never loop over `$(ls)`.** File names with spaces get split. Use a glob:
  `for f in *.txt`.

## Scripts

| Script | Shows |
|--------|-------|
| `01-for-loops.sh` | Lists, ranges, C-style loops, globs |
| `02-while-until.sh` | Counters, waiting for a condition, infinite loops |
| `03-break-continue.sh` | Leaving and skipping iterations, nested loops |
| `04-reading-files.sh` | Line-by-line reading, CSV fields, `mapfile` |
| `05-loop-pitfalls.sh` | `ls` parsing, the pipe-subshell trap, unmatched globs |

## Windows vs Linux

| Topic | Linux / WSL | Git Bash on Windows |
|-------|-------------|---------------------|
| Files with CRLF | Rare | Common. Each `read` line ends in `\r`; strip it with `line="${line%$'\r'}"` |
| Loop speed | Fast | Starting external programs is much slower on Windows. A loop that calls `grep`/`sed` 1,000 times can take minutes. Prefer bash built-ins or one `awk` over many small commands |
| `seq` | Available | Available; `{1..10}` and `(( ))` loops avoid the external program entirely |
| Glob case | `*.TXT` does not match `a.txt` | Globs are still case-sensitive in Git Bash by default, even though the filesystem is not |
| File names with spaces | Possible | Very common (`Program Files`, `My Documents`); quoting in loops is essential |

## Exercises

1. Print the multiplication table for 7 using a C-style loop.
2. Loop over all `.sh` files in a chapter folder and print each name with its
   line count.
3. Write a countdown from 10 to 1 that waits a second between numbers.
4. Read a file line by line and print each line prefixed with its line number.
5. Find the first number above 1000 that is divisible by both 7 and 13, using `break`.
