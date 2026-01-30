Review multiple PRs with inline comments: $ARGUMENTS

## Instructions

Efficiently review multiple PRs with detailed feedback.

### Step 1: For Each PR

```bash
# Get metadata
gh pr view <N> --repo <owner/repo> --json number,title,state,author,commits,files,reviews,comments

# Get existing comments (limit for efficiency)
gh api repos/<owner>/<repo>/pulls/<N>/comments --jq '.[] | {path, line, body, user: .user.login}' | head -30

# Get diff
gh pr diff <N> --repo <owner/repo>
```

### Step 2: Review Each PR

1. Analyze considering existing comments
2. Post inline comments for issues:
   ```bash
   COMMIT=$(gh pr view <N> --repo <owner/repo> --json commits -q '.commits[-1].oid')
   
   gh api repos/<owner>/<repo>/pulls/<N>/comments \
     -f body="[SEVERITY] Issue..." \
     -f commit_id="$COMMIT" \
     -f path="file.py" \
     -F line=45 \
     -f side="RIGHT"
   ```
3. Submit brief review summary

### Step 3: Generate Report

```
Batch Review Report
===================
Date: YYYY-MM-DD
PRs: X reviewed

| PR  | Repo     | Title       | Action  | Issues |
|-----|----------|-------------|---------|--------|
| #40 | backend  | Auth0 Link  | Approve | 0      |
| #28 | frontend | Stripe      | Changes | 1 crit |

Details
-------
PR #40: Ready to merge
PR #28: Critical - missing webhook verification

Comments Posted
---------------
| PR  | File        | Line | Issue              |
|-----|-------------|------|--------------------|
| #28 | service.ts  | 45   | Webhook sig verify |
```

### Severity Tags

- `[CRITICAL]` - Security, must fix
- `[HIGH]` - Bug
- `[MEDIUM]` - Code smell
- `[LOW]` - Minor
- `[FOLLOW-UP]` - Pending from previous
