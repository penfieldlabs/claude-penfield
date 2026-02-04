---
allowed-tools: mcp__plugin_penfield_penfield__recall
description: Search memories with hybrid search
argument-hint: <query>
---

## Your Task

Search for relevant memories using hybrid search (BM25 + vector + graph).

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:recall <query>

Example: /penfield:recall authentication bug"

**Otherwise**, call `mcp__plugin_penfield_penfield__recall` with:
- query: "$ARGUMENTS"
- limit: 10

## Output Format

Display results as a numbered list:
1. **[memory_id]** (relevance: X.XX)
   Content snippet...
   Tags: tag1, tag2

If no results found, say "No memories found for: $ARGUMENTS"

Do not use any other tools. Do not send any other text besides the search results or usage message.
