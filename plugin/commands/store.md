---
allowed-tools: mcp__plugin_penfield_penfield__store
description: Store a new memory
argument-hint: <content>
---

## Your Task

Store the provided content as a new memory. Memory type is auto-detected.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:store <content>

Example: /penfield:store [Decision] Using Redis for caching due to 10x performance improvement"

**Otherwise**, call `mcp__plugin_penfield_penfield__store` with:
- content: "$ARGUMENTS"

## Output Format

Confirm storage:
"Stored memory: [memory_id]
Type: [detected_type]
Importance: [score]"

If storage fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
