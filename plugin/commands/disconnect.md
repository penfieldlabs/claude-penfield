---
allowed-tools: mcp__plugin_penfield_penfield__disconnect
description: Remove connection between memories
argument-hint: <from_id> | <to_id>
---

## Your Task

Remove a relationship between two memories.

**If $ARGUMENTS is empty or doesn't contain a pipe**, respond exactly:
"Usage: /penfield:disconnect <from_id> | <to_id>

Example: /penfield:disconnect abc-123 | def-456"

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character):
- First segment: from_memory UUID (required)
- Second segment: to_memory UUID (required)

Call `mcp__plugin_penfield_penfield__disconnect` with parsed values (trimmed).

## Output Format

Confirm disconnection:
"Disconnected: [from_id] -X-> [to_id]"

If disconnection fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
