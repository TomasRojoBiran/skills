# Skills

A collection of reusable skills for coding agents.

## Structure

```text
skills/     # Skill definitions
commands/   # OpenCode commands
evals/      # Test cases
install.sh  # Installation script
```

## Installation

Run from the repository on Linux:

```bash
./install.sh
```

The script links skills to `~/.agents/skills/` and commands to `~/.config/opencode/commands/` (or your configured OpenCode directory). It leaves existing files untouched.

Run it again when adding new skills or commands. Changes to existing ones are picked up through the links. Restart OpenCode if needed.

## Adding a skill

1. Create a directory under `skills/` with a `SKILL.md` file.
2. Add an OpenCode command under `commands/` if needed.
3. Add test cases under `evals/`.
4. Run `./install.sh` and test the skill.

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode commands](https://opencode.ai/docs/commands/)
