---
allowed-tools: mcp__plugin_penfield_penfield__reflect
description: Analyze recent memory patterns
argument-hint: [time_window]
---

## Your Task

Reflect on recent activity to identify patterns and active topics.

Call `mcp__plugin_penfield_penfield__reflect` with:
- time_window: "$ARGUMENTS" if provided, otherwise "recent"

Valid time_window values: "recent", "today", "week"

## Output Format

Present analysis:

**Reflection: [time_window]**
Memories analyzed: [count]

**Active Topics:**
- topic1 (X mentions)
- topic2 (Y mentions)

**Patterns Identified:**
[insights about activity patterns]

**Recent Activity:**
[summary of what's been happening]

Do not use any other tools. Do not send any other text besides the reflection.
