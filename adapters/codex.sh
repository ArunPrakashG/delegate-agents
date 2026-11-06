# Adapter: OpenAI Codex CLI (`codex exec`). Checked against codex-cli 0.160.0.
# Status: a new run works in principle but is untested. Resume is not supported yet:
# codex names sessions with its own IDs, which this runner does not read.
# The brief is read from stdin ("-"). The last message is saved to <brief>.last.
adapter_check() { command -v codex >/dev/null; }
adapter_start() {
  printf 'codex exec -m %q -s workspace-write --skip-git-repo-check -o %q - < %q' "$1" "$2.last" "$2"
}
adapter_resume() {
  echo "codex: resume is not supported by this adapter yet (see references/sessions.md)" >&2
  return 1
}
