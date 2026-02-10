# Penfield for Claude Code

**Persistent memory that compounds.** Your agent remembers decisions, preferences, and context across every session — and builds knowledge graphs that get smarter over time.

No more Groundhog Day. No more re-explaining your codebase. No more lost context.

---

## Install

```bash
# Add the marketplace
/plugin marketplace add penfieldlabs/claude-penfield

# Install the plugin
/plugin install penfield
```

### Restart and Authenticate

After installing, **restart Claude Code** to load the plugin's MCP server, then authenticate:

1. **Restart Claude Code** (exit and reopen)
2. Run `/mcp` to open the MCP server list
3. Under **Built-in MCPs**, find `plugin:penfield:penfield` and select it
4. Follow the prompts to authenticate with your Penfield account

Sign up for an account at [portal.penfield.app](https://portal.penfield.app/sign-up).

## Install jq

- brew install jq (macOS)
- apt install jq (Linux)

### Already have a user-configured Penfield MCP?

If you previously installed Penfield via `claude mcp add`, you should **disable or remove** it to avoid having duplicate MCP servers:

```bash
# Remove the user-configured MCP
claude mcp remove penfield
```

The plugin-provided MCP (`plugin:penfield:penfield`) includes all the same tools plus hooks and skills. You only need one.

<details>
<summary>Manual MCP-only setup (no plugin features)</summary>

```bash
claude mcp add --transport http penfield https://mcp.penfield.app
```

This gives you the memory tools but none of the plugin features below. **Not recommended** — use the plugin instead.

</details>

---

## What the Plugin Adds (vs. MCP alone)

| Feature | MCP Only | With Plugin |
|---------|----------|-------------|
| Memory tools | Yes | Yes |
| `/penfield:help` quick reference | No | Yes |
| Auto-context on session start | No | Hook injects memory instructions every session |
| Automatic pre-compaction save | No | Subagent saves context before compaction |
| Session log fallback | No | Path injected for searching raw logs |
| Auto-activating skill | No | Claude learns memory best practices automatically |
| Works without remembering to `awaken()` | No | SessionStart hook reminds every time |

**The problem with MCP alone:** Claude has to *decide* to use memory tools. If it forgets, you get a cold start. Hooks are deterministic — they fire every time, guaranteed.

---

## Using Penfield

Just talk naturally. No special commands needed.

- **Remember things:** "Remember this: I prefer morning meetings, not afternoons"
- **Recall things:** "What did we decide about the pricing strategy?"
- **Fix mistakes:** "Update memory: it's actually John who handles legal, not Sarah"
- **Connect ideas:** "Connect this decision to our discussion about customer feedback"
- **Save checkpoints:** "Save a checkpoint for Project Alpha"
- **Resume work:** "Restore the checkpoint for Project Alpha"

Run `/penfield:help` for the full quick reference.

---

## Hooks (Deterministic Memory)

**SessionStart** — Every session, Claude gets injected context:
- Memory system instructions and checklist
- Your personality and preferences reminder
- Session log path for fallback searches

**PreCompact** — Before context compaction, a subagent automatically extracts and saves your working context to Penfield. This runs in the background (async) so it doesn't block your work. Even if you forget to save, your context is preserved.

### Customizing the PreCompact Model

By default, the PreCompact hook uses **Haiku** for cost efficiency. If you want higher quality context extraction, you can upgrade to Sonnet or Opus.

**Option 1: Environment variable** (recommended)
```bash
export PENFIELD_PRECOMPACT_MODEL=sonnet  # Options: haiku (default), sonnet, opus
```

**Option 2: Edit the script directly**

Find this line in `hooks/scripts/pre-compact.sh`:
```bash
PRECOMPACT_MODEL="${PENFIELD_PRECOMPACT_MODEL:-haiku}"
```

Change `haiku` to `sonnet` or `opus`:
```bash
PRECOMPACT_MODEL="${PENFIELD_PRECOMPACT_MODEL:-sonnet}"
```

| Model | Quality |
|-------|---------|
| haiku | Good (default) |
| sonnet | Better |
| opus | Best |

**Note:** Upgrading to sonnet/opus improves extraction quality but increases cost and counts against your Claude subscription usage limits.

### Session Log Fallback

Can't find something in Penfield? The session-start injection includes the path to Claude Code's **complete verbatim session log**. Claude can search it directly when memory recall falls short.

### PreCompact Hook Logs

The PreCompact hook logs to `~/.claude/debug/penfield-precompact.log`:

- **Single file** with simple 5MB rotation (keeps `.old` backup)
- **Structured:** Timestamp | Level | Message
- **Concise:** Success/fail status with session context
- **Location:** Uses existing debug directory (no new directories created)

**View logs:**
```bash
tail -f ~/.claude/debug/penfield-precompact.log
```

---

## Auto-Activating Skill

The plugin includes a skill that Claude activates automatically when memory operations are relevant. It teaches Claude:
- When and what to store proactively
- How to write high-quality memories (not just "user wants X")
- Knowledge graph best practices
- Session lifecycle management

---

## How It Works

Penfield uses **hybrid search** combining three retrieval methods:

- **BM25** (keyword) — exact term matching
- **Vector** (semantic) — meaning-based similarity
- **Graph** (connections) — relationship traversal

Memories aren't just stored — they're **connected**. When you link related memories, recall traverses the graph to surface context that keyword or semantic search alone would miss.

```
Decision: Use Redis for caching
    ├── supports → Benchmark: Redis 10x faster than DB queries
    ├── supersedes → Old decision: Use in-memory cache
    └── influenced_by → User report: API timeout at 100 items
```

---

## Cross-Platform

Same memory, everywhere. Penfield works across:

- **Claude Code** (this plugin)
- **Claude Desktop / Web / Mobile** — via MCP connector
- **Cursor** — via MCP config
- **Windsurf, Cline, Roo Code** — via MCP config
- **Gemini CLI** — via MCP config
- **OpenClaw** — via [native plugin](https://github.com/penfieldlabs/openclaw-penfield)
- **Any MCP client** — `https://mcp.penfield.app`

See [penfield-mcp](https://github.com/penfieldlabs/penfield-mcp) for setup instructions for other platforms.

---

## Plugin Structure

```
claude-penfield/
├── .claude-plugin/
│   └── marketplace.json       # Marketplace catalog
├── plugin/
│   ├── .claude-plugin/
│   │   └── plugin.json        # Plugin manifest
│   ├── .mcp.json              # MCP server config
│   ├── hooks/
│   │   ├── hooks.json         # SessionStart + PreCompact hooks
│   │   └── scripts/
│   │       ├── session-start.sh
│   │       └── pre-compact.sh
│   ├── commands/
│   │   └── help.md            # /penfield:help quick reference
│   └── skills/
│       └── penfield/
│           └── SKILL.md       # Auto-activating memory skill
├── README.md
└── LICENSE
```

**Minimal dependencies. Zero builds. Zero code to maintain.** The plugin is config files, markdown, and two shell scripts. All the heavy lifting happens on the Penfield MCP server.

### Requirements

- **jq** — Required for parsing hook inputs. Install: `brew install jq` (macOS) or `apt install jq` (Linux)

---

## Documentation

- [Tools Reference](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/TOOLS.md) — All tools with parameters and examples
- [Memory Types](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/MEMORY-TYPES.md) — The 11 memory types and when to use each
- [Relationships](https://github.com/penfieldlabs/penfield-mcp/blob/main/docs/RELATIONSHIPS.md) — The 24 relationship types for knowledge graphs
- [AI Agent Guide](https://github.com/penfieldlabs/penfield-mcp/blob/main/SKILL.md) — Instructions for AI agents using Penfield

---

## Links

- **Website:** [penfield.app](https://penfield.app)
- **MCP Setup (all platforms):** [penfieldlabs/penfield-mcp](https://github.com/penfieldlabs/penfield-mcp)
- **X:** [@penfieldlabs](https://x.com/penfieldlabs)
- **GitHub:** [@penfieldlabs](https://github.com/penfieldlabs)

---

## License

MIT
