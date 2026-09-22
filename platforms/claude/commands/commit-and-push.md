Commit and push staged changes: $ARGUMENTS

## Instructions

Write a commit for the staged changes following the Commitizen convention, then push it to the remote.

### Arguments

Format: `["<context>"]`

Optional. A hint about intent or scope, for when the staged diff alone does not make the reason obvious.

Examples:
```
/commit-and-push
/commit-and-push "this reverts the caching change from last week"
```

### Process

1. **Review the staged changes** — read every file currently staged, not just the file names
2. **Compose the message** in Commitizen format:
   - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
   - Format: `<type>(<scope>): <subject>`
   - Subject in imperative mood ("add", not "added")
   - Subject at most 50 characters, lowercase, no trailing period
3. **Create the commit** with that message
4. **Push** to the remote

### Example messages

```
feat(auth): add user login functionality
fix(api): resolve null pointer exception
docs(readme): update installation instructions
chore(deps): update dependencies to latest versions
```
