---
allowed-tools: mcp__plugin_penfield_penfield__retrieve_artifact
description: Retrieve an artifact file
argument-hint: <path>
---

## Your Task

Retrieve the content of a saved artifact.

**If $ARGUMENTS is empty**, respond exactly:
"Usage: /penfield:get-artifact <path>

Example: /penfield:get-artifact /docs/notes.md

Use /penfield:artifacts to list available files."

**Otherwise**, call `mcp__plugin_penfield_penfield__retrieve_artifact` with:
- path: "$ARGUMENTS"

## Output Format

Display the artifact:

**Artifact: [path]**

```
[file content]
```

If artifact not found, say "Artifact not found: $ARGUMENTS"

Do not use any other tools. Do not send any other text besides the content or usage message.
