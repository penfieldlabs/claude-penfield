---
allowed-tools: mcp__plugin_penfield_penfield__delete_artifact
description: Delete an artifact file
argument-hint: <path>
---

## Your Task

Delete a saved artifact.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:delete-artifact <path>

Example: /penfield:delete-artifact /docs/old-notes.md

Use /penfield:artifacts to list available files."

**Otherwise**, call `mcp__plugin_penfield_penfield__delete_artifact` with:
- path: "$ARGUMENTS"

## Output Format

Confirm deletion:
"Deleted artifact: [path]"

If deletion fails, report the error.

Do not use any other tools. Do not send any other text besides the confirmation or usage message.
