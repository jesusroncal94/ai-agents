Implement fullstack feature: $ARGUMENTS

## Instructions

Orchestrate complete fullstack implementation using backend and frontend subagents.

### Arguments

Format: `<analysis_doc> --backend <path> --frontend <path> [--branch <base_branch>] [--mode <sequential|parallel>]`

Example:
```
@ANALYSIS_FEATURE.md --backend /path/to/backend --frontend /path/to/frontend --branch develop
```

Defaults: `--branch develop`, `--mode sequential`

### Implementation Modes

#### Sequential (Default - Recommended)
Best when frontend depends on backend APIs:
1. Delegate to **backend-developer** subagent
2. Wait for backend PR
3. Delegate to **frontend-developer** subagent with backend PR reference
4. Create frontend PR

#### Parallel
Best when API contract is well-defined:
1. Launch both subagents in parallel
2. Coordinate API contract alignment
3. Create both PRs with dependencies noted

### Process

1. **Parse arguments** and review analysis document
2. **Choose mode** based on dependencies
3. **Delegate to subagents**:
   - backend-developer with analysis + backend repo
   - frontend-developer with analysis + frontend repo + backend PR
4. **Coordinate** API contracts, error handling
5. **Integration testing** when both complete

### Coordination Checklist

- [ ] API endpoints match between backend/frontend
- [ ] Request/Response types aligned
- [ ] Error handling consistent
- [ ] Auth flow works end-to-end
- [ ] Docker setup works locally

### Output

```markdown
## Fullstack Implementation Complete

### Backend PR
- URL: [link]
- Changes: [endpoints, database]

### Frontend PR  
- URL: [link]
- Depends on: Backend PR
- Changes: [components, pages]

### Merge Order
1. Backend PR first
2. Frontend PR after backend deployed

### Integration Testing
- [ ] Local testing passed
- [ ] API contract verified
```
