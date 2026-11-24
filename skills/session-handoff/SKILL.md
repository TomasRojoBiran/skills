---
name: session-handoff
description: Prepare a focused, ready-to-paste prompt for a fresh agent session. Use only on explicit request.
metadata:
  opencode/autoinvoke: false
---

Distill the current conversation into a self-contained prompt for a fresh agent. If the user specifies the next session's focus, prioritize context relevant to that goal; otherwise preserve the current objective and next step.

Include only what is useful for continuing:
- Objective, relevant progress, unfinished work, and blockers.
- Important decisions and their rationale, constraints, and unresolved questions.
- Relevant repository/branch, changed files (including uncommitted work), and observed verification results. Inspect current Git status or relevant files read-only if needed. Mark unverified claims and distinguish plans from completed work.
- The next concrete action, its scope, success criteria, and any pending approvals. If planning is unfinished or implementation is not approved, make that explicit.
- References to existing plans, specs, ADRs, issues, commits, and source files instead of repeating them. Suggest relevant known skills only when useful.

Tell the next agent to follow applicable `AGENTS.md`, verify the current state, preserve existing changes, and respect approval gates. Do not invent authorization or missing context. Omit irrelevant history and redact secrets and sensitive data.

Aim for under 500 words; exceed this only when essential. Return only the ready-to-paste prompt in one copyable code block. Do not write files, change Git state, run tests or services, or execute the next task. Stop after the handoff.
