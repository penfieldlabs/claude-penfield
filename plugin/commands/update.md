---
allowed-tools: mcp__plugin_penfield_penfield__update_memory
description: Update an existing memory
argument-hint: <memory_id> | [content] | [importance] | [tags]
---

## Your Task

Update an existing memory.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:update <memory_id> | [content] | [importance] | [tags]

Examples:
/penfield:update abc-123 | New content here
/penfield:update abc-123 | | 0.9
/penfield:update abc-123 | | | python,debugging
/penfield:update abc-123 | Updated content | 0.8 | python,fixed"

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character):
- First segment: memory_id (required)
- Second segment: new content (optional, empty to keep existing)
- Third segment: new importance 0.0-1.0 (optional)
- Fourth segment: new tags comma-separated (optional, replaces existing)

Call `mcp__plugin_penfield_penfield__update_memory` with parsed values (trimmed).
Only include parameters that have non-empty values.

## Output Format

Confirm update:
"Updated memory: [memory_id]"

If update fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
