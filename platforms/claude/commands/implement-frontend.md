Implement frontend feature: $ARGUMENTS

## Instructions

Delegate implementation to the **frontend-developer** subagent.

### Arguments

Format: `<analysis_doc> --repo <frontend_path> [--branch <base_branch>] [--backend-pr <pr_url>] [--context "<context>"]`

Example:
```
@ANALYSIS_FEATURE.md --repo /path/to/frontend --branch develop --backend-pr https://github.com/org/repo/pull/123
```

Defaults: `--branch develop`

### Process

1. **Parse arguments** - Extract document, repo, branch
2. **Delegate to frontend-developer subagent** with:
   - Analysis document content
   - Repository path
   - Backend PR for API reference
   - Context

The frontend-developer will:
1. Setup: checkout branch, npm install
2. Review UI/UX requirements
3. Create feature branch
4. Implement: Types → API → Hooks → Components → Pages
5. Verify: lint, type-check, tests, build
6. Commit and create PR

### Implementation Order

1. **Types**: Interfaces for data structures
2. **API**: Fetch functions with error handling
3. **Hooks**: Custom hooks for data
4. **Components**: Atomic design pattern
5. **Pages**: Compose components
6. **Styles**: Tailwind/CSS refinements

### Verification

```bash
npm run lint && npm run type-check && npm test && npm run build
```

### Output

1. Summary of implementation
2. Components created
3. Screenshots (if applicable)
4. PR link
5. Backend dependencies
