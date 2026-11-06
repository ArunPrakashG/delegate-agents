# Dispatch one delegation

1. **Pick the adapter and model.** Use the roster. Choose the cheapest model that can do the task.
2. **Write a self-contained brief.** Put it in a folder that is not a project, such as a scratch folder. The brief states the goal, the exact files, the expected output and the constraints. Use paths relative to the work directory. Include no personal identifiers, secrets or absolute home paths.
3. **Run the runner.** Use `run_in_background` for long runs.
   ```bash
   <plugin-root>/scripts/agent-tmux <adapter> <workdir> <brief-file> <model> [timeout-seconds]
   ```
   The runner prints `agent session: ses_…`. Save that ID. Only a follow-up needs it (see `sessions.md`).
4. **Read the result.** The log is `<brief-file>.log`. Its last line is `exit=<code>`. A non-zero code means the run failed. Diagnose the cause first, then retry. Don't rerun the same command unchanged.
5. **Verify the work.** Read the changed files or the diff. Run the tests if the project has them. Report the result as checked only after you have checked it.
