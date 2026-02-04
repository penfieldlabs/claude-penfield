---
allowed-tools: mcp__plugin_penfield_penfield__save_context
description: Save session context checkpoint
argument-hint: <name> | [description]
---

## Your Task

Save the current cognitive context for later resumption.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:save <name> | [description]

Examples:
/penfield:save API Investigation
/penfield:save API Investigation | Found rate limiting bug in handler.py"

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character):
- First segment: checkpoint name (required)
- Second segment: detailed description for cognitive handoff (optional)

Call `mcp__plugin_penfield_penfield__save_context` with:
- name: parsed name (trimmed)
- description: parsed description if provided (trimmed)

## Output Format

Confirm save:
"Context saved: [name]
ID: [context_id]
Memories included: [count]"

If save fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
