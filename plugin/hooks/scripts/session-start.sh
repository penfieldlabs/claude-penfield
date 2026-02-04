#!/bin/bash
# Penfield SessionStart Hook
# Injects memory system context into Claude's context at session start.
#
# This hook MUST always produce output - it injects the <penfield-memory>
# block that Claude sees. Failures should degrade gracefully, not silently.

#######################################
# Parse hook input (graceful fallback)
#######################################
if command -v jq &> /dev/null; then
    INPUT=$(cat)
    TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)
    # Sanitize path - remove any characters that could break shell or markdown
    TRANSCRIPT_PATH=$(echo "$TRANSCRIPT_PATH" | tr -cd 'a-zA-Z0-9_./-')
    # Validate path is within expected directory (prevent directory traversal)
    if [ -n "$TRANSCRIPT_PATH" ] && [[ "$TRANSCRIPT_PATH" != "$HOME/.claude/"* ]]; then
        TRANSCRIPT_PATH=""
    fi
else
    # Consume stdin even if we can't parse it
    cat > /dev/null
    TRANSCRIPT_PATH=""
fi

#######################################
# Build dynamic fallback section
#######################################
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
    FALLBACK_SECTION="### Session Log Fallback
If Penfield recall doesn't surface what you need, this session's **complete verbatim log** is at:
\`$TRANSCRIPT_PATH\`

Parse with jq: \`cat \"$TRANSCRIPT_PATH\" | jq -r 'select(.type==\"user\") | .message.content' | grep -i \"keyword\"\`"
else
    FALLBACK_SECTION="### Session Log Fallback
If Penfield recall doesn't surface what you need, session logs are at:
\`~/.claude/projects/{project-hash}/{session-id}.jsonl\`

Parse with jq: \`cat ~/.claude/projects/*/*.jsonl | jq -r 'select(.type==\"user\") | .message.content' | grep -i \"keyword\"\`"
fi

#######################################
# Output the penfield-memory block
#######################################
cat << PENFIELD_CONTEXT
<penfield-memory>
## Penfield Memory System Active

You have persistent memory via the Penfield MCP server. This means you can remember things across sessions — decisions, preferences, context, and knowledge graphs that compound over time.

### Session Startup Checklist
1. **Call \`awaken()\`** to load your personality and user preferences
2. **Call \`reflect("recent")\`** to orient on recent work
3. Use \`recall()\` before answering questions — check what you already know

### During the Session
- **Store** important decisions, corrections, breakthroughs, and user preferences
- **Connect** related memories to build knowledge graphs (no orphan memories)
- **Recall** before responding to questions about past work or context

### Before Session Ends
- If substantive work was done, use \`save_context()\` with a detailed cognitive handoff
- This ensures the next session can pick up exactly where you left off

### Available Tools (17)
**Memory:** store, recall, search, fetch, update_memory
**Knowledge Graph:** connect, disconnect, explore
**Context:** awaken, reflect, save_context, restore_context, list_contexts
**Artifacts:** save_artifact, retrieve_artifact, list_artifacts, delete_artifact

Use \`/penfield:help\` for the full command reference.

$FALLBACK_SECTION
</penfield-memory>
PENFIELD_CONTEXT
