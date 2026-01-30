Implement backend feature: $ARGUMENTS

## Instructions

Delegate implementation to the **backend-developer** subagent.

### Arguments

Format: `<analysis_doc> --repo <backend_path> [--branch <base_branch>] [--context "<context>"]`

Example:
```
@ANALYSIS_FEATURE.md --repo /path/to/backend --branch develop --context "Use Docker, Stripe test mode"
```

Defaults: `--branch develop`

### Process

1. **Parse arguments** - Extract document, repo, branch
2. **Delegate to backend-developer subagent** with:
   - Analysis document content
   - Repository path
   - Branch and context

The backend-developer will:
1. Setup: checkout branch, pull latest
2. Review requirements from analysis
3. Create feature branch
4. Implement: DB → Services → API → Tests
5. Verify: tests, lint, no secrets
6. Commit and create PR

### Implementation Order

1. **Database**: Models, migrations
2. **Services**: Business logic with error handling
3. **API**: Endpoints with validation
4. **Integrations**: Third-party (Stripe, etc.)
5. **Tests**: Unit + integration

### Docker Usage

```bash
docker-compose up -d
docker-compose exec api pytest
docker-compose exec api flake8
```

### Output

1. Summary of implementation
2. Files created/modified
3. API endpoints created
4. Database changes
5. PR link
6. Next steps (frontend)
