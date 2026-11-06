# delegate-agents

A Claude Code plugin with two skills that share one tmux runner.

- **`delegate-agents`** hands a well-specified task to another agent CLI (opencode, codex, or `claude -p`) and gets the result back. Sessions can be resumed by ID.
- **`tmux-run`** runs long-lived or long-running commands (servers, builds, watchers) in named tmux sessions. An agent can start a job, check it, wait for it and stop it without managing tmux itself. It works on its own, and `delegate-agents` uses it too.

## Status

| Agent CLI | Status |
|---|---|
| opencode | Tested |
| codex | Adapter written, untested |
| claude (`claude -p`) | Adapter written, untested. Resume is not supported. |
| antigravity | Stub |

## Requirements

- bash
- tmux
- the agent CLI you want to delegate to, for example opencode

## Install

```bash
git clone https://github.com/ArunPrakashG/delegate-agents.git
claude plugin marketplace add ./delegate-agents
claude plugin install delegate-agents@delegate-agents
```

Or, inside Claude Code: `/plugin marketplace add <path-to-clone>`, then `/plugin install delegate-agents@delegate-agents`.

## Safety

The opencode adapter runs with `--auto`, so the delegate can run shell commands and edit files without asking. Point it at a directory you are willing to let it change, and keep secrets out of its brief.

`tmux-run` keeps its state in `$TMUX_RUN_STATE`, or in `$XDG_STATE_HOME/tmux-run` when that is unset.

## Layout

- `skills/delegate-agents/`: the delegation skill and its references
- `skills/tmux-run/`: the standalone tmux skill
- `agents/delegate.md`: the subagent that runs a delegation
- `scripts/tmux-run`: the tmux runner (start, status, log, wait, ready, send, stop, list)
- `scripts/agent-tmux`: the delegation runner, built on `tmux-run`
- `adapters/`: one file per agent CLI

## Adding an agent CLI

Follow `skills/delegate-agents/references/discovery.md`, then write `adapters/<name>.sh` following `adapter-contract.md`.

## License

MIT. See [LICENSE](LICENSE).
