# Release Process

This document outlines the release process for the Penfield Claude Code plugin.

## Version Numbering

We follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **MAJOR** version: Incompatible API changes
- **MINOR** version: New functionality in a backwards-compatible manner
- **PATCH** version: Backwards-compatible bug fixes

## Pre-Release Checklist

- [ ] All tests passing
- [ ] Documentation updated
- [ ] CHANGELOG.md updated with release notes
- [ ] Version bumped in:
  - [ ] `.claude-plugin/marketplace.json`
  - [ ] `plugin/.claude-plugin/plugin.json`
- [ ] Git working directory clean
- [ ] Changes reviewed and approved

## Release Steps

### 1. Prepare Release Branch

```bash
git checkout main
git pull origin main
git checkout -b release/v{VERSION}
```

### 2. Update Version Numbers

Update version in:
- `.claude-plugin/marketplace.json`
- `plugin/.claude-plugin/plugin.json`

### 3. Update CHANGELOG.md

Move items from `[Unreleased]` to new version section:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Feature descriptions

### Fixed
- Bug fix descriptions
```

### 4. Commit Changes

```bash
git add .
git commit -m "chore: release v{VERSION}"
```

### 5. Create and Push Tag

```bash
git tag -a v{VERSION} -m "Release v{VERSION}"
git push origin release/v{VERSION}
git push origin v{VERSION}
```

### 6. Merge to Main

```bash
git checkout main
git merge release/v{VERSION}
git push origin main
```

### 7. Create GitHub Release

1. Go to GitHub repository
2. Click "Releases" → "Draft a new release"
3. Select the tag `v{VERSION}`
4. Title: `v{VERSION}`
5. Description: Copy relevant section from CHANGELOG.md
6. Publish release

### 8. Deploy to Plugin Marketplace

The plugin marketplace automatically picks up new versions from the git repository.
Users will receive updates when they run `claude plugin update`.

## Post-Release

- [ ] Verify plugin installs correctly: `claude plugin install penfield`
- [ ] Test basic functionality in new installation
- [ ] Announce release in appropriate channels
- [ ] Close related issues and PRs

## Hotfix Process

For urgent fixes to production:

1. Create hotfix branch from main: `git checkout -b hotfix/v{VERSION}`
2. Make fix and update CHANGELOG.md
3. Bump PATCH version
4. Follow release steps 4-8
5. Merge back to main

## Rollback Procedure

If a release has critical issues:

1. Identify last known good version
2. Create rollback tag: `git tag -a v{VERSION}-rollback -m "Rollback to v{GOOD_VERSION}"`
3. Communicate rollback to users
4. Fix issues and create new release

## Version History

- **v1.1.0** (2026-02-09): Natural language UX — replaced 17 slash commands with conversational interface, added timestamp to PreCompact context names to prevent duplicates
- **v1.0.1** (2026-02-05): Fixed duplicate context saves in PreCompact hook
- **v1.0.0** (2026-02-03): Initial release — persistent memory with knowledge graphs, SessionStart and PreCompact hooks
