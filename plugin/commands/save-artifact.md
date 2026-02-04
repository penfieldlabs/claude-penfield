---
allowed-tools: mcp__plugin_penfield_penfield__save_artifact
description: Save an artifact file
argument-hint: <path> | <content>
---

## Your Task

Save content as an artifact file.

**If $ARGUMENTS is empty or doesn't contain a pipe**, respond exactly:
"Usage: /penfield:save-artifact <path> | <content>

Example: /penfield:save-artifact /docs/notes.md | # My Notes

This is the content of my notes file."

**Otherwise**, parse $ARGUMENTS by splitting on "|" (pipe character, first occurrence only):
- First segment: path including filename (required), e.g. "/docs/notes.md"
- Remaining text: file content (required)

Call `mcp__plugin_penfield_penfield__save_artifact` with:
- path: parsed path (trimmed)
- content: remaining content after first pipe (preserve formatting)

## Output Format

Confirm save:
"Artifact saved: [path] ([size] bytes)"

If save fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
