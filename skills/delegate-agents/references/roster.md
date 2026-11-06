# Roster

| Adapter | CLI (version tested) | Status |
|---|---|---|
| `opencode` | opencode 2.2.5 | Working. One-shot runs, named sessions and resume are tested. Model format `provider/model`. List models with `opencode models`. |
| `codex` | codex-cli 0.160.0 | Discovered, not run. Resume not supported yet. |
| `claude` | Claude Code `claude -p` | Discovered, not run. Resume not supported yet. |
| `antigravity` | not installed | Stub. Discovery needed once installed. |
| OpenRouter | no standalone CLI found | Not an adapter. Test whether the `opencode` adapter can reach it, using `opencode models`. |

Record the CLI version and the test date when you change a row. CLI flags change between releases.

Before sending a task to a provider, check that its data handling fits the task. A brief can include the project's code, so keep secrets and private data out of it.
