---
name: penfield
description: |
  Persistent memory management with Penfield. Activate when the task involves:
  remembering past work, recalling previous decisions, storing important context,
  building knowledge graphs, saving/restoring session context, reflecting on
  recent activity, managing artifacts, or any situation where cross-session
  memory would improve the response. Also activate at the start of any new
  session to orient on recent work.
---

# Penfield Memory System

You have access to Penfield, a persistent memory system with hybrid search (BM25 + vector + graph), knowledge graphs, and context management. Memory persists across all sessions and platforms.

## Session Lifecycle

### Starting a Session
1. Call `awaken()` to load personality configuration and user preferences
2. Call `reflect({ time_window: "recent" })` to see what you've been working on lately
3. Let this context shape your first response — don't greet cold

### During a Session
- **Before answering questions about past work:** Call `recall()` first — check what you already know
- **When important things happen:** Store decisions, corrections, breakthroughs, and user preferences
- **After storing:** Connect related memories using `connect()` — no orphan memories
- **When the user says "remember this":** Always store immediately

### Ending a Session
- If substantive work was done, call `save_context()` with a detailed cognitive handoff:
  - What you were investigating
  - Key discoveries and decisions
  - Current hypotheses and open questions
  - Suggested next steps
  - References to specific memory IDs

## Memory Types (11)

Memory type is **auto-detected** from content — you don't pass it as a parameter. Write descriptively so the system classifies correctly. Here's what each type represents:

### Core Types (8)
| Type | When to Use |
|------|-------------|
| `fact` | Verified, durable information — preferences, specs, organizational data, stable reference material |
| `insight` | Patterns, realizations, conclusions drawn from observations — discovered patterns, analysis findings, non-obvious connections |
| `correction` | Fixes to prior understanding — misconceptions corrected, outdated assumptions updated, "we thought X but actually Y" |
| `conversation` | Session summaries, notable exchanges — important discussions, decision-making contexts, how conclusions were reached |
| `reference` | Source material, citations, external documentation — RFCs, spec links, documentation URLs, quoted external sources |
| `task` | Work items, action items, todos — pending work, follow-ups, investigation needs, deferred decisions |
| `strategy` | Approaches, methods, plans — problem-solving approaches, workflow preferences, codebase mental models, repeatable processes |
| `checkpoint` | Milestone states, progress markers — project progress snapshots, phase completions, handoff points |

### Identity Types (3)
| Type | When to Use |
|------|-------------|
| `identity_core` | Immutable identity facts — role, location, core attributes |
| `personality_trait` | Behavioral patterns and communication preferences — interaction styles, tendencies |
| `relationship` | Connections between entities — collaborations, project dependencies, reporting structures |

## What to Store (Proactively)

Store without being asked:
- User preferences and corrections ("I prefer X over Y")
- Important decisions and the reasoning behind them
- Breakthroughs and key discoveries
- Corrections to previous understanding
- Architectural decisions and tradeoffs
- Recurring patterns you notice across sessions

Do NOT store:
- Trivial conversational exchanges
- Information that's easily searchable
- Verbatim transcripts
- Ephemeral task state
- Non-consented personal data

## Memory Quality Guidelines

**Good memory:**
```
[Project Alpha - API Design] DECISION: Using event-driven architecture over
request/response for the notification service. Rationale: 3 downstream consumers
need async processing, and we hit 340ms latency with synchronous calls. User
approved this direction after reviewing the latency benchmarks.
```

**Bad memory:**
```
User wants event-driven architecture.
```

Include: WHAT happened, WHY it matters, HOW you got there, and EVIDENCE supporting it.

## Importance Scale

| Score | Usage |
|-------|-------|
| 0.9–1.0 | Critical decisions, corrections, core preferences |
| 0.7–0.8 | Project context, key facts |
| 0.5–0.6 | General preferences, session summaries |
| 0.3–0.4 | Minor background details |
| 0.1–0.2 | Typically not worth storing |

## Knowledge Graph Best Practices

After storing a memory, always ask yourself:
1. What previous memory does this update or contradict? → `supersedes` or `contradicts`
2. What evidence does this provide? → `supports` or `disputes`
3. What caused this or what will it cause? → `influenced_by` or `causes`
4. What concrete example is this? → `example_of` or `implements`
5. What sequence is this part of? → `follows` or `precedes`

The richer the graph, the smarter the recall.

## Search Tips

Choose the right tool based on query intent:

| Query Type | Tool | Notes |
|------------|------|-------|
| Exact terms/keywords | `recall` | Hybrid search with BM25 + vector + graph |
| Concept/semantic | `search` | Pure semantic similarity |
| Filter by category | `recall` with `tags` | Pass tags list for OR-based filtering |
| Time-bounded | `recall` with dates | Use `start_date`/`end_date` params |

## Memory Maintenance

- Use `update_memory()` to fix errors in existing memories — don't create correction memories for typos
- Use tags for categorization (2–5 lowercase tags), but don't use dates as tags (timestamps are automatic)
- Use `disconnect()` to remove incorrect relationships

## Available Tools

| Tool | Purpose |
|------|---------|
| `awaken` | Load personality and user preferences |
| `recall` | Hybrid search (BM25 + vector + graph) |
| `search` | Semantic search with higher vector weight |
| `store` | Save new memory (type auto-detected) with importance, tags |
| `fetch` | Get memory by UUID |
| `update_memory` | Modify existing memory |
| `connect` | Link two memories with a relationship |
| `disconnect` | Remove a connection between memories |
| `explore` | Traverse knowledge graph from a memory |
| `reflect` | Analyze recent memory patterns |
| `save_context` | Save cognitive checkpoint |
| `restore_context` | Resume from checkpoint |
| `list_contexts` | Show all saved checkpoints |
| `save_artifact` | Store a file |
| `retrieve_artifact` | Get a stored file |
| `list_artifacts` | Browse stored files |
| `delete_artifact` | Remove a stored file |

## Relationship Types (24)

### Knowledge Evolution
- `supersedes` — New memory replaces the old one; old understanding is obsolete
- `updates` — New memory adds to or refines the old one without replacing it
- `evolution_of` — New memory represents a natural progression from the old one

### Evidence
- `supports` — New memory provides evidence for the existing one
- `contradicts` — New memory conflicts with the existing one
- `disputes` — New memory raises questions without definitively contradicting

### Hierarchy
- `parent_of` — Memory is a broader category containing the target
- `child_of` — Memory is a specific instance or subset of the target
- `sibling_of` — Memories are peers at the same level of hierarchy
- `composed_of` — Memory is made up of the target memories
- `part_of` — Memory is a component of the target

### Causation
- `causes` — Memory directly leads to the target outcome
- `influenced_by` — Memory was shaped by the target
- `prerequisite_for` — Memory must be completed before the target can proceed

### Implementation
- `implements` — Memory is a concrete realization of the target concept
- `documents` — Memory describes or explains the target
- `tests` — Memory validates the target
- `example_of` — Memory is an instance demonstrating the target pattern

### Conversation
- `responds_to` — Memory is a direct response to the target
- `references` — Memory mentions or cites the target
- `inspired_by` — Memory draws ideas from the target without directly responding

### Sequence
- `follows` — Memory comes after the target in sequence
- `precedes` — Memory comes before the target in sequence

### Dependency
- `depends_on` — Memory requires the target to function or make sense

## Local Session Logs (Fallback)

Can't find what you need in Penfield? **Check the local session logs.** Claude Code maintains complete verbatim transcripts locally — nothing summarized, nothing lost.

### When to Check the Logs

**Proactively check when:**
- User says "we discussed this" but Penfield recall returns nothing relevant
- You're certain something was said but can't find it stored
- Need exact wording, not a summary
- Penfield MCP is disconnected or erroring

**Don't just say "I can't find that" — check the logs first.**

### Where They Are

Check your `<penfield-memory>` block at session start — it includes the exact path for this session. General pattern:
```
~/.claude/projects/{project-hash}/{session-id}.jsonl
```

To find all session logs:
```bash
ls -la ~/.claude/projects/*/*.jsonl
```

### How to Search

```bash
# Search for a keyword in current project's logs
cat ~/.claude/projects/*/*.jsonl | jq -r 'select(.message.content) | .message.content' | grep -i "keyword"

# Get last 20 user messages from most recent session
cat $(ls -t ~/.claude/projects/*/*.jsonl | head -1) | jq -r 'select(.type=="user") | .message.content' | tail -20

# Find when something was discussed (with timestamps)
cat ~/.claude/projects/*/*.jsonl | jq -r 'select(.message.content | test("keyword"; "i")) | "\(.timestamp): \(.message.content[0:100])"' 2>/dev/null
```

### Log Structure

Each line is a JSON object with:
- `type`: "user", "assistant", "system", "progress"
- `timestamp`: ISO 8601 timestamp
- `message.content`: The actual text
- `uuid`: Unique message ID

Penfield is your primary memory. Local logs are your verbatim backup. **Use both.**
