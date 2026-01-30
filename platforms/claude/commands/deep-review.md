Perform exhaustive deep review of PR: $ARGUMENTS

## Instructions

Run parallel specialized reviews using security, performance, and quality subagents.

### Step 1: Get PR Data

```bash
gh pr view <N> --repo <owner/repo> --json number,title,state,body,commits,files,reviews,comments
gh api repos/<owner>/<repo>/pulls/<N>/comments --jq '.[] | {id, path, line, body, user: .user.login}' | head -50
gh pr diff <N> --repo <owner/repo>
```

### Step 2: Parallel Specialized Reviews

Delegate to subagents in parallel:

1. **security-reviewer** - Vulnerabilities, auth, OWASP
2. **performance-reviewer** - N+1, memory, complexity  
3. **quality-reviewer** - SOLID, DRY, maintainability

Each subagent will post inline comments for issues found.

### Step 3: Interact with Existing Comments

- **Complement**: Add context to existing observations
- **Confirm**: Validate if evidence supports
- **Contradict**: Respectfully disagree with reasoning

### Step 4: Submit Review

Brief summary (details in inline comments):

```bash
gh pr review <N> --repo <owner/repo> --<action> --body "$(cat <<'EOF'
Deep Review Summary

| Category     | New | Pending | Fixed |
|--------------|-----|---------|-------|
| Security     | X   | X       | X     |
| Performance  | X   | X       | X     |
| Quality      | X   | X       | X     |

Critical issues: [list if any]
See inline comments for details.

Verdict: [ACTION]
EOF
)"
```

### Decision Matrix

| Critical Issues | Action |
|-----------------|--------|
| >= 1            | request-changes |
| 0, high issues  | comment |
| 0, minor        | approve |
