# AI Agents Repository

A centralized repository for AI agents, commands, and configurations across multiple AI platforms.

## Overview

This repository provides reusable AI agent configurations, custom commands, and best practices for integrating AI assistants into development workflows. Currently supports Claude Code, with architecture designed for future platform expansion.

## Supported Platforms

| Platform | Status | Description |
|----------|--------|-------------|
| [Claude Code](platforms/claude/) | ✅ Active | Anthropic's Claude Code agents and commands |
| Cursor | 🔜 Planned | Cursor IDE AI configurations |
| GitHub Copilot | 🔜 Planned | GitHub Copilot custom instructions |

## Repository Structure

```
ai-agents/
├── platforms/
│   └── claude/                 # Claude Code platform
│       ├── agents/             # Subagent definitions
│       ├── commands/           # Slash commands
│       ├── settings.json       # Permissions config
│       └── README.md           # Platform documentation
├── examples/                   # Usage examples
├── scripts/                    # Installation/setup scripts
└── README.md                   # This file
```

## Quick Start

### Claude Code

1. **Copy to your project:**
   ```bash
   cp -r platforms/claude/.  /path/to/your/project/.claude/
   ```

2. **Or use the install script:**
   ```bash
   ./scripts/install-claude.sh /path/to/your/project
   ```

3. **Start using commands:**
   ```bash
   /analyze-feature @PLANNING.md --backend /path/backend --frontend /path/frontend
   /implement-backend @ANALYSIS.md --repo /path/backend
   /review-pr owner/repo#123
   ```

## Available Agents

### Claude Code Agents

| Agent | Model | Purpose |
|-------|-------|---------|
| `tech-lead` | opus | Deep technical analysis, architecture decisions |
| `backend-developer` | sonnet | Backend implementation (Python, Node.js) |
| `frontend-developer` | sonnet | Frontend implementation (React, TypeScript) |
| `debugger` | sonnet | Bug diagnosis and fixing |
| `security-reviewer` | sonnet | Security vulnerability detection |
| `performance-reviewer` | haiku | Performance issue detection |
| `quality-reviewer` | haiku | Code quality and SOLID principles |

### Model Selection Rationale

| Model | Cost | Best For |
|-------|------|----------|
| **opus** | $5/$25 MTok | Complex reasoning, architecture, high-impact decisions |
| **sonnet** | $3/$15 MTok | Coding, debugging, security analysis |
| **haiku** | $1/$5 MTok | Pattern matching, high-frequency tasks |

## Available Commands

### Development Workflow

| Command | Description |
|---------|-------------|
| `/analyze-feature` | Technical analysis with tech-lead agent |
| `/implement-backend` | Backend implementation |
| `/implement-frontend` | Frontend implementation |
| `/implement-fullstack` | Full-stack orchestration |
| `/fix-bug` | Bug diagnosis and fix |

### Code Review

| Command | Description |
|---------|-------------|
| `/review-pr` | Single PR review with inline comments |
| `/review-pr-batch` | Multiple PR review |
| `/deep-review` | Parallel security + performance + quality review |

### Testing & Validation

| Command | Description |
|---------|-------------|
| `/test-feature` | Comprehensive feature testing |
| `/validate-feature` | Plan vs implementation validation |

## Contributing

### Adding a New Agent

1. Create agent file in `platforms/<platform>/agents/`
2. Follow the frontmatter format:
   ```yaml
   ---
   name: agent-name
   description: What the agent does. Use proactively when...
   model: sonnet
   permissionMode: plan
   tools:
     - Read
     - Grep
   disallowedTools:
     - Write
   ---
   ```
3. Add concise system prompt
4. Update platform README

### Adding a New Platform

1. Create directory: `platforms/<platform-name>/`
2. Add platform-specific README
3. Follow existing structure for agents/commands
4. Update main README with platform status

## Best Practices

### Agent Design

- **Proactive descriptions**: Include "use proactively when..." for automatic delegation
- **Permission modes**: Use `plan` for read-only, `acceptEdits` for development
- **Tool restrictions**: Use `disallowedTools` to prevent unwanted actions
- **Concise prompts**: Focus on behavior when invoked, not extensive documentation

### Model Selection

- Use **opus** only for high-impact, low-frequency tasks
- Default to **sonnet** for coding and complex reasoning
- Use **haiku** for well-defined, high-frequency patterns

## License

MIT License - See [LICENSE](LICENSE) for details.

## Links

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [CLI Reference](https://docs.anthropic.com/en/docs/claude-code/cli-reference)
