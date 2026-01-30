Fix bug: $ARGUMENTS

## Instructions

Delegate debugging and fixing to the **debugger** subagent.

### Arguments

Format: `<bug_description_or_doc> --repo <repo_path> [--branch <base_branch>] [--context "<context>"]`

Examples:
```
@BUG_ISSUE.md --repo /path/to/repo --branch develop
"Duplicate emails after purchase" --repo /path/to/backend
```

Defaults: `--branch develop`

### Process

1. **Parse arguments** - Extract bug info, repo, branch
2. **Delegate to debugger subagent** with:
   - Bug description/document
   - Repository path  
   - Branch and context

The debugger will:
1. Reproduce the bug locally
2. Investigate root cause (logs, recent commits)
3. Create fix branch: `fix/<bug-name>`
4. Implement minimal fix
5. Add regression test
6. Verify and commit
7. Create PR

### Commit Format

```bash
git commit -m "fix(<scope>): <description>

Problem: <what was happening>
Cause: <why it was happening>
Solution: <what was changed>

Fixes: #<issue>"
```

### PR Template

```
## Bug Description
[User-facing impact]

## Root Cause
[Technical explanation]

## Solution
[What was changed]

## Testing
- [x] Bug no longer reproduces
- [x] Regression test added
- [x] All tests pass
```

### Output

1. Bug summary and root cause
2. Fix applied
3. Testing done
4. PR link
5. Prevention suggestions
