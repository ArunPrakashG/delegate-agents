# Adapter: Claude Code headless mode (`claude -p`). Checked against `claude --help`.
# Status: a new run works in principle but is untested. Resume is not supported yet:
# --continue picks the latest conversation in the directory, which is unsafe when
# two delegations share a directory, and --session-id needs a UUID.
# acceptEdits allows file edits without prompts. It does not approve shell commands.
adapter_check() { command -v claude >/dev/null; }
adapter_start() {
  printf 'claude -p --model %q --permission-mode acceptEdits < %q' "$1" "$2"
}
adapter_resume() {
  echo "claude: resume is not supported by this adapter yet (see references/sessions.md)" >&2
  return 1
}
