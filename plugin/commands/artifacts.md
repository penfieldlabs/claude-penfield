---
allowed-tools: mcp__plugin_penfield_penfield__list_artifacts
description: List saved artifacts
argument-hint: [path]
---

## Your Task

List artifacts in the specified directory.

Call `mcp__plugin_penfield_penfield__list_artifacts` with:
- path_prefix: "$ARGUMENTS" if provided, otherwise "/"

## Output Format

Display directory contents:

**Artifacts at [path]**

Folders:
- folder1/
- folder2/

Files:
- file1.md (1024 bytes)
- file2.txt (512 bytes)

If directory is empty, say "No artifacts at: [path]"

Do not use any other tools. Do not send any other text besides the listing.
