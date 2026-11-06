---
name: tmux-run
description: Run long-lived or long-running commands (dev servers, web or API servers, builds, test suites, watchers, emulators, training, large installs) in named tmux sessions, and check on them later, without managing tmux yourself. Use when a command must outlive the tool call, keeps running until stopped, or takes more than a minute or two. Also use when a process must receive input later.
---

# tmux-run: long commands without babysitting

Use `scripts/tmux-run` at the plugin root. It starts a command in a detached tmux session, writes its output to a log, and gives you a few commands to check on it. You never type tmux commands yourself.

Do not run long jobs in the Bash tool or with a bare `&`. Do not run them through a `preview_start` command either.

## Commands

```bash
TR=<plugin-root>/scripts/tmux-run
$TR start <name> <workdir> -- <command> [args...]   # start; name must be unique while running
$TR status <name>                                    # running | exited <code> | stopped
$TR log <name> [lines]                               # recent output
$TR wait <name> [timeout-seconds]                    # block until done; exits with the command's code
$TR ready <name> '<regex>' [timeout]                 # block until the log matches
$TR ready <name> http://localhost:<port>/ [timeout]  # block until a URL answers
$TR send <name> <text>                               # type into a running command (for stdin)
$TR stop <name>                                      # kill it
$TR list                                             # every run and its status
```

Add `--log <file>` before `--` to write the output to a file you choose. The log ends with `exit=<code>` when the command finishes.

## Servers

1. Start the server, then wait for it to be ready with `ready`. Starting is not enough.
2. Check the port first (`ss -ltnp | rg :<port>`). If something else holds it, stop that process deliberately.
3. Give the user the URL, the session name, and `tmux attach -t tr-<name>` so they can watch it.
4. When you are done, `stop` the servers you started, unless the user wants them kept.

## Rules

- Pick a descriptive name per task, such as `myapp-web` or `myapp-build`.
- Use `status`, `log` and `ready` to check on work. Don't block on a long command in the Bash tool.
- A name can be reused only after its previous run has finished or been stopped.
- Tell the user the name and the attach command for anything they might want to watch.
- Don't run several heavy jobs at once on a machine with limited RAM.
- Stop what you started when you finish, and say so.
