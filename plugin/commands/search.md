---
allowed-tools: mcp__plugin_penfield_penfield__search
description: Semantic search for concepts
argument-hint: <query>
---

## Your Task

Search for memories using pure semantic similarity (higher vector weight than recall).

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:search <query>

Example: /penfield:search authentication patterns"

**Otherwise**, call `mcp__plugin_penfield_penfield__search` with:
- query: "$ARGUMENTS"
- limit: 10

## Output Format

Display results as a numbered list with citation info:
1. **[id]** title
   Content text...

If no results found, say "No memories found for: $ARGUMENTS"

Do not use any other tools. Do not send any other text besides the search results or usage message.
