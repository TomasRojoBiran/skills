---
name: handoff
description: Prepare a focused handoff for a fresh agent session. Use only on explicit request.
metadata:
  opencode/autoinvoke: false
---

Distill the current session into a self-contained prompt for a fresh agent. Prioritize the user's intended focus for the next session.

- Preserve relevant progress, decisions, rationale, constraints, and blockers.
- Distinguish proposed, completed, and verified work. Preserve uncommitted changes and pending approvals.
- Specify the next actionable step and its scope.
- Reference existing documentation and source files instead of duplicating them.
- Suggest relevant skills when useful.
- Omit irrelevant history and redact sensitive information.

Return only a concise, ready-to-paste prompt in a single code block. Keep all actions read-only; do not write files or continue the task.
