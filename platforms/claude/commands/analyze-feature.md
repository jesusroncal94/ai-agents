Perform deep technical analysis of feature: $ARGUMENTS

## Instructions

Delegate analysis to the **tech-lead** subagent for comprehensive feature analysis.

### Arguments

Format: `<planning_doc> --backend <path> --frontend <path> [--context "<context>"]`

Example:
```
@FEATURE_PLANNING.md --backend /path/to/backend --frontend /path/to/frontend
```

### Process

1. **Parse arguments** - Extract paths and document
2. **Delegate to tech-lead subagent** with full context:
   - Planning document content
   - Repository paths
   - Additional context

The tech-lead will:
- Read and understand requirements
- Explore both repositories
- Analyze architecture and gaps
- Generate `ANALYSIS_<FEATURE>.md`

### Output

The tech-lead subagent will produce:
- Executive summary
- Current state analysis
- Implementation plan with tasks
- API contracts
- Database changes
- Risk assessment
- Open questions

### Notes

- This is READ-ONLY analysis - no code changes
- Use `git` and `gh` from within respective directories
- Check docker-compose.yml for service configs
