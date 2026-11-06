# Adapter contract

An adapter is `adapters/<name>.sh`. The runner `source`s it and calls these functions. Each one prints one shell command on stdout, so the runner can wrap it in `timeout` and redirect its output.

| Function | Arguments | Must do |
|---|---|---|
| `adapter_check` | none | Return 0 if the CLI is installed. Otherwise print a message to stderr and return non-zero. |
| `adapter_start` | `model brief session-id` | Print the command for a new turn. Pass the session ID only if the CLI accepts one. |
| `adapter_resume` | `model brief session-id` | Print the command that continues that session. If the CLI cannot do this, print an error to stderr and return 1. |

Rules:

- Quote every value with `printf %q`, so the brief path and model name cannot break the command.
- The brief should go in by stdin or a file flag, never by pasting its text into the command.
- Keep the command to one line.
- Set no environment variables that a user might already have. Read optional settings like `OPENCODE_AGENT` only when they are set.

Exit codes from the runner:

- `2`: no adapter file, or bad arguments
- `3`: `adapter_check` failed (CLI missing)
- `1`: `adapter_start` or `adapter_resume` failed, for example an unsupported resume
- otherwise: the CLI's own exit code, written to the log as `exit=<code>`
