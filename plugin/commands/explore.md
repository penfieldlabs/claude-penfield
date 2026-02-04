---
allowed-tools: mcp__plugin_penfield_penfield__explore
description: Explore memory connections
argument-hint: <memory_id> | [depth]
---

## Your Task

Traverse the knowledge graph from a starting memory.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:explore <memory_id> | [depth]

Examples:
/penfield:explore abc-123
/penfield:explore abc-123 | 5"

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character):
- First segment: start_memory UUID (required)
- Second segment: max_depth 1-10 (optional, default 3)

Call `mcp__plugin_penfield_penfield__explore` with parsed values (trimmed).

## Output Format

Display the knowledge graph:

**Exploring from: [memory_id]**
Depth: [max_depth]
Paths found: [count]

**Connections:**
[memory_id] --[relationship]--> [connected_id]: [snippet]
  └── [relationship]--> [next_id]: [snippet]

If no connections found, say "No connections from: [memory_id]"

Do not use any other tools. Do not send any other text besides the graph or usage message.
