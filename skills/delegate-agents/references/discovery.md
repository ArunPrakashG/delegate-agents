# Discovering a new CLI

Do this before you write an adapter. Note the answers in the adapter's header comment, with the version and the date.

1. **Installed?** `command -v <cli>`, then `<cli> --version`. If it is not installed, leave the stub in place and stop.
2. **Non-interactive mode.** Read `<cli> --help`, then the help for the subcommand that runs one prompt and exits, such as `run`, `exec` or `-p`.
3. **Prompt input.** Prefer stdin (`-`, or `< file`). Otherwise use a file-attachment flag, such as `opencode -f`. Put the short message before a list flag, because some parsers swallow everything after it. Use a plain positional argument only for short prompts.
4. **Working directory.** The runner already `cd`s into the work directory, so only add a directory flag if the CLI needs one.
5. **Model.** Find the flag and the format, and how to list models.
6. **Auto-approve.** Find the flag that stops prompts. Work out what it allows. Some CLIs need a separate flag before they can run shell commands.
7. **Session IDs.** Find a flag that sets or reads a session ID. Check whether the CLI accepts an ID you choose, or whether it issues its own. Record which.
8. **Memory test.** Run the test below. Only mark resume as supported if it passes.
9. **Write the adapter** following `adapter-contract.md`.
10. **Update the roster.** Record the version and the test result.

## Memory test

Use a scratch folder, not a project.

1. Store a word in a new session: "Remember this code word: `<WORD-A>`. Reply with only READY."
2. Start a second session and store a different word, `<WORD-B>`.
3. Ask session 1 for its word. It must return `<WORD-A>`.
4. Ask session 2 for its word. It must return `<WORD-B>`.
5. Start a third session with no ID and ask for the word. It must not return either.

Use real code words, not `WORD`, so you can tell an answer from a guess. Check the logs.

## Cost

Each smoke test calls a real model and uses quota. Confirm with the user before testing an expensive model. Cheap models are fine for the tests above.
