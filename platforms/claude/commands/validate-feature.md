Validate feature implementation against plan: $ARGUMENTS

## Instructions

Perform pre-merge validation that implementation matches planning document.

### Arguments

Format: `<analysis_doc> --pr <pr_url_or_number> --repo <repo_path>`

Example:
```
@ANALYSIS_FEATURE.md --pr 123 --repo /path/to/backend
```

### Step 1: Gather Information

```bash
gh pr view <N> --repo <owner/repo> --json number,title,state,body,commits,files,additions,deletions
gh pr diff <N> --repo <owner/repo>
```

### Step 2: Extract Plan Requirements

From analysis document:
- Files to create
- Files to modify
- API endpoints
- Database changes
- Business logic requirements
- Test coverage expected

### Step 3: Compare Plan vs Implementation

#### File Checklist
| Planned | Status | Notes |
|---------|--------|-------|
| file.py | ✅/⚠️/❌ | details |

#### API Contract
| Endpoint | Planned | Implemented |
|----------|---------|-------------|
| GET /api/x | response | ✅ matches |

#### Database
| Table/Column | Migration | Model |
|--------------|-----------|-------|
| table_name | ✅/❌ | ✅/❌ |

### Step 4: Identify Gaps

#### ❌ Missing (Blocks merge)
- Critical items not implemented

#### ⚠️ Partial (Should fix)
- Incomplete implementations

#### 📝 Follow-up (Can be later)
- Nice-to-have items

### Step 5: Generate Report

```markdown
# Feature Validation Report

**PR:** #X | **Completion:** X%

| Category | Planned | Implemented |
|----------|---------|-------------|
| Files | X | X |
| Endpoints | X | X |
| Tests | X | X |

## Status: 🔴/🟡/🟢

### Blocking Issues
1. [list]

### Recommendations
- Before merge: [list]
- Follow-up: [list]
```

### Step 6: Post Comment (if issues)

```bash
gh pr comment <N> --repo <owner/repo> --body "## Validation: [STATUS]
### Blocking: [list]
### Action Required: [instructions]"
```

### Status Icons

| Icon | Meaning |
|------|---------|
| ✅ | Complete |
| ⚠️ | Partial |
| ❌ | Missing |
| 🔴 | Not ready |
| 🟡 | Needs fixes |
| 🟢 | Ready |
