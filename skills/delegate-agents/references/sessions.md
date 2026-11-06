# Sessions and resume

## What a run remembers

Each run is a new process. A run with no session starts with no memory of earlier runs. That is the default, and it is what you want for independent tasks.

A **session** is the agent's saved conversation. Resuming a session means the next run continues that conversation, so the agent still has the earlier turns in context.

## How the runner handles it

- A new delegation gets a fresh session ID, printed as `agent session: …`.
- A follow-up passes that ID back with `--session <id> --resume`:
  ```bash
  <plugin-root>/scripts/agent-tmux opencode <workdir> <followup-brief> <model> 900 --session ses_… --resume
  ```
- The follow-up brief is a new file. Only the conversation is kept, not the brief.

## What was tested with opencode

- Session `A` stored `GRAPE-9`, session `B` stored `MANGO-5`. Asking `A` returned `GRAPE-9`, and asking `B` returned `MANGO-5`. The sessions did not mix.
- A run started without a session did not know the code word (`NONE`).
- Resuming by session ID returned the stored word (`KIWI-4`).
- A version that used `--continue` (latest session) lost the memory once another directory had run. That is why the runner uses explicit IDs.

Test this on any new CLI before you rely on it. See `discovery.md`.

## Rules

- Keep one session per parallel task. Two tasks sharing a session will mix their context.
- Always pass the session ID with `--resume`. Without an ID, `--resume` is refused.
- Adapters for `codex` and `claude` refuse `--resume` for now, because their session IDs have not been wired up.
