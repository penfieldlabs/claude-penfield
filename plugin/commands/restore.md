---
allowed-tools: mcp__plugin_penfield_penfield__restore_context
description: Restore session context
argument-hint: <name>
---

## Your Task

Resume work from a saved context checkpoint.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:restore <name>

Example: /penfield:restore API Investigation

Use /penfield:contexts to list available checkpoints."

**Otherwise**, call `mcp__plugin_penfield_penfield__restore_context` with:
- name: "$ARGUMENTS"

## Output Format

Present the cognitive briefing clearly:

**Context Restored: [name]**

[description/briefing content]

**Related Memories:** [count]
[List key memories with IDs]

If context not found, say "Context not found: $ARGUMENTS"

Do not use any other tools. Do not send any other text besides the briefing or usage message.
