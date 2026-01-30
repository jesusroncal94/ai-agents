Review PR with detailed inline comments: $ARGUMENTS

## Instructions

Perform comprehensive code review with inline comments.

### Step 1: Get PR Data

```bash
gh pr view <N> --repo <owner/repo> --json number,title,state,author,commits,files,reviews,comments
gh api repos/<owner>/<repo>/pulls/<N>/comments --jq '.[] | {path, line, body, user: .user.login}' | head -50
gh pr diff <N> --repo <owner/repo>
```

### Step 2: Analyze Code

Review for:
- **Security**: Vulnerabilities, auth, injection
- **Performance**: N+1, complexity, memory
- **Quality**: SOLID, DRY, readability

### Step 3: Interact with Existing Comments

| Situation | Action |
|-----------|--------|
| Agree | Reply confirming, add context |
| Disagree | Reply respectfully with reasoning |
| Already noted | Don't duplicate |
| Previous fixed | Note as [FIXED] |
| Previous pending | Add [FOLLOW-UP] |

### Step 4: Post Inline Comments

```bash
COMMIT=$(gh pr view <N> --repo <owner/repo> --json commits -q '.commits[-1].oid')

gh api repos/<owner>/<repo>/pulls/<N>/comments \
  -f body="[SEVERITY] Brief Title

Problem (1-2 sentences).

Current:
    <code>

Fix:
    <code>" \
  -f commit_id="$COMMIT" \
  -f path="file.py" \
  -F line=45 \
  -f side="RIGHT"
```

### Step 5: Submit Review

```bash
gh pr review <N> --repo <owner/repo> --<action> --body "$(cat <<'EOF'
Review Summary

Issues: X new, Y pending, Z resolved

Key items:
- [NEW] Issue description (file:line)
- [PENDING] From previous review
- [FIXED] Resolved issue

See inline comments for details.
EOF
)"
```

### Severity Tags

- `[CRITICAL]` - Security, must fix
- `[HIGH]` - Bug, significant
- `[MEDIUM]` - Code smell
- `[LOW]` - Minor improvement
- `[FOLLOW-UP]` - Previous pending

### Decision Matrix

| Critical | Action |
|----------|--------|
| >= 1 | request-changes |
| 0, high issues | comment |
| 0, minor | approve |
