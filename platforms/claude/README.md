# Claude Code Platform

Configuration for Claude Code agents and commands, following the [official Anthropic documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents).

## Installation

Copy the contents to your project's `.claude/` directory:

```bash
# From repository root
cp -r platforms/claude/* /path/to/your/project/.claude/
```

Or use the install script:

```bash
./scripts/install-claude.sh /path/to/your/project
```

## Structure

```
claude/
├── agents/                    # Specialized subagents
│   ├── tech-lead.md          # Technical analysis (opus)
│   ├── backend-developer.md  # Backend development (sonnet)
│   ├── frontend-developer.md # Frontend development (sonnet)
│   ├── debugger.md           # Debugging and fixes (sonnet)
│   ├── security-reviewer.md  # Security review (sonnet)
│   ├── performance-reviewer.md # Performance review (haiku)
│   └── quality-reviewer.md   # Quality review (haiku)
├── commands/                  # Custom slash commands
│   ├── analyze-feature.md
│   ├── implement-backend.md
│   ├── implement-frontend.md
│   ├── implement-fullstack.md
│   ├── fix-bug.md
│   ├── review-pr.md
│   ├── review-pr-batch.md
│   ├── deep-review.md
│   ├── test-feature.md
│   └── validate-feature.md
├── settings.json             # Permissions configuration
└── README.md                 # This file
```

## Agents

### Roles and Models

| Agent | Role | Model | Mode |
|-------|------|-------|------|
| tech-lead | Deep analysis, architecture | **opus** | plan (read-only) |
| backend-developer | Backend implementation | **sonnet** | acceptEdits |
| frontend-developer | Frontend implementation | **sonnet** | acceptEdits |
| debugger | Debug and fix bugs | **sonnet** | acceptEdits |
| security-reviewer | Security review | **sonnet** | plan (read-only) |
| performance-reviewer | Performance review | **haiku** | plan (read-only) |
| quality-reviewer | Quality review | **haiku** | plan (read-only) |

### Model Selection Rationale (Claude 4.5)

| Model | Cost/MTok | Latency | Recommended Use |
|-------|-----------|---------|-----------------|
| **opus** | $5/$25 | Moderate | Architectural analysis, high-impact decisions |
| **sonnet** | $3/$15 | Fast | Coding, debugging, security review |
| **haiku** | $1/$5 | Fastest | Well-defined patterns, high frequency |

**Selection criteria:**

1. **tech-lead → opus**: Multi-repository synthesis, gap analysis, risk assessment. Maximum intelligence justified by low usage frequency.

2. **backend/frontend-developer → sonnet**: Anthropic states Sonnet is "optimal for coding and agentic tasks".

3. **debugger → sonnet**: Root cause analysis requires causal reasoning and hypothesis formation.

4. **security-reviewer → sonnet**: Vulnerabilities can be subtle (race conditions, injection patterns).

5. **performance-reviewer → haiku**: N+1 queries, missing indexes are well-defined patterns.

6. **quality-reviewer → haiku**: SOLID, DRY are clear rules with defined checklists.

### Key Features

Each agent includes:

- **`description`** with "use proactively" for automatic invocation
- **`permissionMode`**: `plan` for reviewers (read-only), `acceptEdits` for developers
- **`disallowedTools`**: Reviewers cannot Write/Edit
- **Concise prompts** following official examples

## Commands

### Development

| Command | Description |
|---------|-------------|
| `/analyze-feature` | Deep technical analysis → tech-lead |
| `/implement-backend` | Backend implementation → backend-developer |
| `/implement-frontend` | Frontend implementation → frontend-developer |
| `/implement-fullstack` | Fullstack sequential/parallel |
| `/fix-bug` | Debug and fix → debugger |

### Review

| Command | Description |
|---------|-------------|
| `/review-pr` | Complete review with inline comments |
| `/review-pr-batch` | Review multiple PRs |
| `/deep-review` | Parallel review: security + performance + quality |

### Testing

| Command | Description |
|---------|-------------|
| `/test-feature` | Comprehensive feature testing |
| `/validate-feature` | Plan vs implementation validation |

## Usage Examples

### Analysis and Development

```bash
# 1. Technical analysis
/analyze-feature @FEATURE_PLANNING.md --backend /path/backend --frontend /path/frontend

# 2. Backend implementation
/implement-backend @ANALYSIS_FEATURE.md --repo /path/backend

# 3. Frontend implementation
/implement-frontend @ANALYSIS_FEATURE.md --repo /path/frontend --backend-pr 123

# 4. Validation
/validate-feature @ANALYSIS_FEATURE.md --pr 124 --repo /path/backend
```

### Deep Review

```bash
# Parallel review with specialists
/deep-review owner/repo#123
```

### Fix Bug

```bash
/fix-bug @BUG_ISSUE.md --repo /path/backend
# or
/fix-bug "Bug description" --repo /path/backend --branch develop
```

## Configuration

### settings.json

The `settings.json` file configures permissions:

```json
{
  "permissions": {
    "allow": [
      "Task(tech-lead)",
      "Task(backend-developer)",
      "Bash(gh pr:*)",
      "Bash(docker-compose:*)"
    ]
  }
}
```

### Customization

To customize for your project:

1. **Add project-specific tools** to settings.json allow list
2. **Modify agent prompts** to include project conventions
3. **Add custom commands** for your workflow

## References

- [Official subagents documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [CLI reference](https://docs.anthropic.com/en/docs/claude-code/cli-reference)
- [Settings](https://docs.anthropic.com/en/docs/claude-code/settings)
