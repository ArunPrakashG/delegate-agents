# Adapter: opencode CLI (https://opencode.ai). Checked against opencode 2.2.5.
# Session IDs must start with "ses". `-s <id>` creates the session if it is new,
# and continues it if it exists, so start and resume run the same command.
# OPENCODE_AGENT (optional) picks one of opencode's agents.
# The brief goes in with -f, so its text is never shell-quoted.
adapter_check() { command -v opencode >/dev/null; }
adapter_start() {
  printf 'opencode run -m %q -s %q %s --auto %q -f %q' "$1" "$3" \
    "${OPENCODE_AGENT:+--agent $OPENCODE_AGENT}" "Follow the attached brief exactly." "$2"
}
adapter_resume() {
  printf 'opencode run -m %q -s %q %s --auto %q -f %q' "$1" "$3" \
    "${OPENCODE_AGENT:+--agent $OPENCODE_AGENT}" "Continue from the attached brief." "$2"
}
