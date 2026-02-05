# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2026-02-05

### Fixed
- **Critical:** Fixed duplicate context saves in PreCompact hook caused by subprocess output being captured by main assistant
  - Prevents hook prompt from leaking to main conversation
  - Ensures hook prompt only goes to Haiku subprocess via `claude -p`
- Fixed exit code capture in PreCompact hook from `${PIPESTATUS[0]}` to `$?`

### Changed
- **Logging improvements:** Migrated from `/tmp` to Claude Code debug directory
  - Logs now stored in `~/.claude/debug/penfield-precompact.log`
  - Uses existing debug directory (no new directories created)
  - Single file with simple 5MB rotation (keeps `.old` backup)
  - Structured logging with timestamps and log levels
  - Concise success/fail status with session context
- **Environment variable:** Renamed `PRECOMPACT_MODEL` to `PENFIELD_PRECOMPACT_MODEL` for clarity

## [1.0.0] - 2026-02-03

### Added
- **Persistent memory system for Claude Code that builds knowledge graphs across sessions**
  - Remembers decisions, preferences, context - compounds over time
- **Memory storage with semantic/hybrid search**
  - BM25 + vector + graph hybrid search
  - 11 memory types (fact, insight, correction, conversation, reference, task, strategy, checkpoint, identity_core, personality_trait, relationship)
- **Knowledge graph connections between memories**
  - 24 relationship types for building rich knowledge graphs
  - Explore tool for graph traversal
- **Session context saving/restoration**
  - save_context, restore_context, list_contexts
  - Cognitive handoff between sessions
- **Personality/preference loading (awaken)**
  - Load user preferences and personality configuration
- **Pattern analysis (reflect)**
  - Analyze recent memory patterns and topics
- **Artifact management**
  - save_artifact, retrieve_artifact, list_artifacts, delete_artifact
- **18 commands & skills**
  - recall, store, connect, explore, search, fetch, update_memory, disconnect, awaken, reflect, save_context, restore_context, list_contexts, save_artifact, retrieve_artifact, list_artifacts, delete_artifact, summarize
- **SessionStart hook**
  - Auto-loads personality and previous context
- **PreCompact hook**
  - Saves context before summarization
- **MCP server integration**
  - Full integration with Claude Code plugin system

[Unreleased]: https://github.com/penfieldlabs/claude-penfield/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/penfieldlabs/claude-penfield/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/penfieldlabs/claude-penfield/releases/tag/v1.0.0
