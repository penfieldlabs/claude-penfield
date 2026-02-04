---
allowed-tools: mcp__plugin_penfield_penfield__connect
description: Connect two memories
argument-hint: <from_id> | <to_id> | <relationship>
---

## Your Task

Create a relationship between two memories in the knowledge graph.

**If $ARGUMENTS is empty or doesn't contain two pipes**, respond exactly:
"Usage: /penfield:connect <from_id> | <to_id> | <relationship>

Example: /penfield:connect abc-123 | def-456 | supports

Relationship types:
- Knowledge: supersedes, updates, evolution_of
- Evidence: supports, contradicts, disputes
- Hierarchy: parent_of, child_of, sibling_of
- Causation: causes, influenced_by, prerequisite_for
- Implementation: implements, documents, tests, example_of
- Sequence: follows, precedes
- Dependency: depends_on"

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character):
- First segment: from_memory UUID (required)
- Second segment: to_memory UUID (required)
- Third segment: relationship_type (required)

Call `mcp__plugin_penfield_penfield__connect` with parsed values (trimmed).

## Output Format

Confirm connection:
"Connected: [from_id] --[relationship]--> [to_id]"

If connection fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
