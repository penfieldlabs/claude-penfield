---
description: Show available Penfield commands
argument-hint:
---

# Penfield Memory Commands

Display this help information to the user:

## Memory Operations

| Command | Description |
|---------|-------------|
| `/penfield:recall <query>` | Search memories (hybrid: BM25 + vector + graph) |
| `/penfield:search <query>` | Semantic search (pure vector similarity) |
| `/penfield:store <content>` | Store a new memory (type auto-detected) |
| `/penfield:fetch <id>` | Get full memory by UUID |
| `/penfield:update <id> \| [content] \| [importance] \| [tags]` | Update existing memory |

## Knowledge Graph

| Command | Description |
|---------|-------------|
| `/penfield:connect <from> \| <to> \| <relationship>` | Link two memories |
| `/penfield:disconnect <from> \| <to>` | Remove a link |
| `/penfield:explore <id> \| [depth]` | Traverse connections from a memory |

## Context Management

| Command | Description |
|---------|-------------|
| `/penfield:save <name> \| [description]` | Save session context checkpoint |
| `/penfield:restore <name>` | Resume from saved checkpoint |
| `/penfield:contexts` | List all saved checkpoints |
| `/penfield:reflect [time_window]` | Analyze recent memory patterns |
| `/penfield:awaken` | Load personality configuration |

## Artifacts

| Command | Description |
|---------|-------------|
| `/penfield:artifacts [path]` | List saved files |
| `/penfield:save-artifact <path> \| <content>` | Save a file |
| `/penfield:get-artifact <path>` | Retrieve a file |
| `/penfield:delete-artifact <path>` | Delete a file |

## Pipe-Separated Arguments

Commands with multiple arguments use `|` as separator:
```
/penfield:connect abc-123 | def-456 | supports
/penfield:save My Checkpoint | Description of what I was working on
```

## Learn More

- [Tools Reference](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/TOOLS.md)
- [Memory Types](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/MEMORY-TYPES.md)
- [Relationships](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/RELATIONSHIPS.md)

Do not call any tools. Just display this help text.
