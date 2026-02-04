---
allowed-tools: mcp__plugin_penfield_penfield__fetch
description: Get a memory by ID
argument-hint: <memory_id>
---

## Your Task

Fetch the full content of a specific memory by its UUID.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:fetch <memory_id>

Example: /penfield:fetch a1b2c3d4-e5f6-7890-abcd-ef1234567890"

**Otherwise**, call `mcp__plugin_penfield_penfield__fetch` with:
- id: "$ARGUMENTS"

## Output Format

Display the full memory:
**Memory: [id]**
Type: [type]
Created: [timestamp]
Importance: [score]
Tags: [tags]

Content:
[full content]

Relationships: [if any]

If memory not found, say "Memory not found: $ARGUMENTS"

Do not use any other tools. Do not send any other text besides the memory details or usage message.
