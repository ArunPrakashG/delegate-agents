---
name: delegate-agents
description: Hand a well-specified task to another agent CLI (opencode, codex, claude -p, or an OpenRouter-backed tool) and get the result back, with tmux running each turn. Use when the user asks to delegate or hand off work, run a task on a cheaper or companion model, talk to another agent CLI, continue an earlier delegated session, or add a new agent CLI.
---

# Delegate to agent CLIs

A delegate is a second agent running as its own process. It gets a brief, works in a directory, and returns output. You plan, write the brief, and verify the result.

Run the loop through the `delegate` agent. Its run logs and CLI details then stay out of this conversation.

## How to delegate

Launch the `delegate` agent with:
- the adapter name (see references/roster.md)
- the model, always explicit
- the work directory
- the brief: a file path, or the text to write into one
- for a follow-up, the session ID from the earlier run

It returns the session ID, the exit code, a short summary, and what it checked. Keep the session ID if you may need a follow-up.

## Rules

- Always pass a model. Never rely on a CLI's default.
- Briefs contain no personal identifiers, secrets, tokens or absolute home-directory paths.
- Check delegated output yourself before you call it done.

## References (load only when needed)

- `references/roster.md`: supported CLIs, their status, and their adapter names
- `references/dispatch.md`: the steps for one delegation
- `references/sessions.md`: what resume means and how to continue a session
- `references/discovery.md`: how to learn a new CLI's flags and add an adapter
- `references/adapter-contract.md`: what an adapter must provide

The runner is `scripts/agent-tmux` at the plugin root. From this skill's folder that is `../../scripts/agent-tmux`.
