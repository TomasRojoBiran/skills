# Skills

My skills for coding agents.

## Structure

```text
skills/     # Skill definitions
commands/   # OpenCode commands
evals/      # Evaluations
install.sh  # Installer
```

## Installation

```bash
./install.sh
```

The installer links skills to `~/.agents/skills/` and commands to `~/.config/opencode/commands/`.

Existing conflicts and duplicate definitions are removed and replaced as needed. Unrelated skills and commands are left untouched.

Run the installer when adding new skills or commands. Changes to existing ones require no reinstallation.

## Development

1. Create a directory under `skills/` containing a `SKILL.md`.
2. Add a command under `commands/` if needed.
3. Define evaluations under `evals/`.
4. Install and evaluate the skill.

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode commands](https://opencode.ai/docs/commands/)
