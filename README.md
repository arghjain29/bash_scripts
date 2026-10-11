# Bash Scripting: Beginner to Advanced

A hands-on course for learning Bash scripting, organised as numbered chapters.
Each chapter is a folder with a `README.md` (concepts, notes, exercises) and
several small, heavily commented example scripts.

The examples are Bash everywhere. On Windows that means **Git Bash** or **WSL**;
wherever behaviour differs from Linux, the chapter README has a
**Windows vs Linux** section.

## Who this is for

- Beginners who have never written a shell script.
- Developers who copy-paste shell snippets and want to actually understand them.
- Engineers who want to write advanced scripts: safe, debuggable and
  automatable.

## Setup

| Platform | What to use | Notes |
|----------|-------------|-------|
| Linux | Built-in terminal | Bash is almost always preinstalled. Check with `bash --version`. |
| Windows (option 1) | [Git Bash](https://git-scm.com/download/win) | Lightweight. Ships Bash plus common Unix tools. No `cron`, `flock`, or `jq` by default. |
| Windows (option 2) | [WSL](https://learn.microsoft.com/windows/wsl/install) (`wsl --install`) | A real Linux environment. Behaves like Linux in almost every chapter. |
| macOS | Terminal | Ships Bash 3.2. Install a modern one with `brew install bash` for chapters 7+. |

The examples are written for **Bash 4.4 or newer** (current Linux, WSL and
Git Bash all ship 5.x). Check yours:

```bash
bash --version
```

## How to run the examples

```bash
cd 01-getting-started
bash 01-hello-world.sh
```

Running with `bash script.sh` works everywhere and does not need the executable
bit. To run a script as `./script.sh` on Linux or WSL, make it executable first:

```bash
chmod +x 01-hello-world.sh
./01-hello-world.sh
```

> **Line endings matter.** Bash scripts must use LF line endings, not Windows
> CRLF. This repo ships a `.gitattributes` that forces LF for `*.sh` files.
> Chapter 1 explains the `$'\r': command not found` error you get otherwise.

## Chapters

Chapters are being published one at a time. A linked title means the chapter
is available now.

| # | Chapter | What you learn | Status |
|---|---------|----------------|--------|
| 01 | [Getting Started](01-getting-started/) | Running scripts, shebang, detecting the OS, line endings | Available |
| 02 | [Variables and Quoting](02-variables-and-quoting/) | Variables, quoting rules, environment, command substitution, arithmetic | Available |
| 03 | Input and Output | `echo`/`printf`, `read`, redirection, pipes, here-documents | Coming soon |
| 04 | Conditionals | `if`, `[ ]` vs `[[ ]]`, file tests, `case`, exit codes | Coming soon |
| 05 | Loops | `for`, `while`, `until`, reading files safely, common pitfalls | Coming soon |
| 06 | Functions | Arguments, return values, scope, sourcing libraries | Coming soon |
| 07 | Strings and Arrays | Parameter expansion, indexed and associative arrays | Coming soon |
| 08 | Files and Paths | File operations, globbing, `find`, temp files, permissions | Coming soon |
| 09 | Text Processing | `grep`, `sed`, `awk`, `cut`/`sort`/`uniq`, regex | Coming soon |
| 10 | Arguments and Options | Positional args, `shift`, `getopts`, long options | Coming soon |
| 11 | Error Handling and Debugging | Strict mode, `trap`, cleanup, tracing, logging | Coming soon |
| 12 | Processes and Jobs | Background jobs, `wait`, signals, subshells, parallelism | Coming soon |
| 13 | Scheduling and Automation | `cron`, Windows Task Scheduler, lock files, idempotency | Coming soon |
| 14 | Networking and APIs | `curl`, `jq`, retries, `ssh`/`scp` | Coming soon |
| 15 | Best Practices | Portability, security, templates, ShellCheck, testing with `bats` | Coming soon |
| 16 | Real-World Projects | Backup, log analyzer, health check, deploy, bulk rename | Coming soon |
| 17 | Bash for DevOps | Docker wrappers, container entrypoints, `.env` and secrets, CI pipelines, releases, Kubernetes rollouts | Coming soon |

## Suggested path

- **Beginner (chapters 01-06):** enough to write and read simple scripts.
- **Intermediate (chapters 07-10):** data handling and proper command-line tools.
- **Advanced (chapters 11-17):** robust, automatable, production-style scripts,
  ending with containers, CI and deployments in chapter 17 (read chapters 10,
  11 and 14 before it).

For each chapter: read the README, read each script top to bottom, run it,
change something and run it again, then do the exercises.

## Conventions used in this repo

- Every script starts with `#!/usr/bin/env bash`.
- Scripts are numbered in the order they should be read.
- Scripts that create files do so in a temporary directory and clean up.
- From chapter 11 onward, scripts use strict mode (`set -euo pipefail`).
- Scripts that need the network, extra tools, or user input say so at the top.
- Scripts that could change something outside the repo (Docker, Git tags, a
  cluster, a remote host) only print their commands unless told otherwise.

## Useful tools

- [ShellCheck](https://www.shellcheck.net/): a linter that catches most Bash mistakes.
- [explainshell.com](https://explainshell.com/): paste a command, see what each part does.
- `man bash`, and `help <builtin>` (for example `help read`) for built-in commands.
