# agent-skills

Personal, reusable skills for coding agents. Keep workflows small, explicit, and tested. The repository contains instructions and evaluations, not project-specific state or conversation history.

## Skills

| Skill | Purpose | OpenCode command |
| --- | --- | --- |
| [session-handoff](skills/session-handoff/SKILL.md) | Transfer relevant context to a fresh session as a copyable prompt. | `/session-handoff [optional focus]` |

## Layout

```text
agent-skills/
├── skills/         # Portable Agent Skills (one directory per skill)
├── commands/       # OpenCode-specific slash commands
├── evals/          # Manual evaluation cases and expected behavior
├── install.sh      # Safe local symlink installer (Linux/Bash)
├── .gitignore
└── README.md
```

## Install locally (recommended)

Keep this repository in a stable location, for example `~/personal/agent-skills`. On Linux, run:

```bash
cd ~/personal/agent-skills
./install.sh
```

The installer links individual skill directories into `~/.agents/skills/` and OpenCode commands into `${XDG_CONFIG_HOME:-$HOME/.config}/opencode/commands/`. It does not require Node.js, does not modify repositories you work in, and refuses to overwrite existing paths. Re-running is safe for links pointing at the same checkout. Do not move the checkout without updating the links.

If you installed an older handoff version directly in OpenCode's configuration, move those old definitions outside any discovered skills/commands directory before running the installer. For the default paths:

```bash
backup=$(mktemp -d "$HOME/session-handoff-backup.XXXXXX")
for path in "$HOME/.config/opencode/skills/session-handoff" \
            "$HOME/.config/opencode/commands/session-handoff.md"; do
    if [ -e "$path" ] || [ -L "$path" ]; then
        mv -- "$path" "$backup/"
    fi
done
./install.sh
```

If dotfiles already manage these paths, remove or migrate the old definitions there too. With a custom `XDG_CONFIG_HOME`, adapt the backup paths. An existing shared copy or project-specific skill may also take precedence; avoid duplicate skill IDs.

OpenCode reads the shared skill directory. Other agents may use it too, but discovery and invocation behavior depend on their versions. The command is OpenCode-specific. The OpenCode 2 metadata hides `session-handoff` from automatic skill discovery; OpenCode 1 and other agents may ignore it. The explicit-only description still applies, and is not a security boundary.

For distribution to other agents, an alternative is `npx skills add <github-user>/agent-skills -g`; that installs skills but not our custom OpenCode commands. Use one installation method per skill to avoid duplicate copies. The local symlink installer is the preferred method for developing this repository.

## Use

```text
/session-handoff
/session-handoff Focus on validating the migration before implementation.
```

Copy the generated prompt, create a fresh session in the same workspace with the appropriate agent mode, and paste it. A handoff is not a new approval. The skill does not save files or automatically continue the task.

## Add or change a skill

1. Create `skills/<skill-name>/SKILL.md` with `name`, `description`, and focused instructions. Start with a real recurring workflow.
2. Add a thin command under `commands/` only if a manual OpenCode entry point is useful.
3. Add cases under `evals/`, covering expected behavior and a failure mode.
4. Run `./install.sh` to link new definitions. Existing linked files update automatically on edit or pull; restart OpenCode if needed.
5. Test on realistic sessions and commit the change. Keep project instructions in the project's own `AGENTS.md` instead.

See [handoff evaluations](evals/session-handoff.md). Start with manual tests; introduce an automated harness only when the number or frequency of tests warrants it. No live agent behavior has been verified yet.

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode commands](https://opencode.ai/docs/commands/)
- [Matt Pocock's skills](https://github.com/mattpocock/skills)
- [Amp's handoff design](https://ampcode.com/news/handoff)
