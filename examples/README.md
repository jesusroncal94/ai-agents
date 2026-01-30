# Examples

This directory contains usage examples for AI agents across different platforms.

## Claude Code Examples

### Full Development Workflow

A complete example showing how to use agents for a feature implementation:

```bash
# Step 1: Create a planning document
cat > FEATURE_PLANNING.md << 'EOF'
# Feature: User Profile Settings

## Requirements
- Users can update their profile picture
- Users can change display name
- Users can set timezone preferences

## Acceptance Criteria
- Profile changes saved to database
- Changes reflected immediately in UI
- Validation on all inputs
EOF

# Step 2: Analyze the feature
/analyze-feature @FEATURE_PLANNING.md \
  --backend /path/to/backend \
  --frontend /path/to/frontend

# Step 3: Implement backend
/implement-backend @ANALYSIS_USER_PROFILE.md \
  --repo /path/to/backend \
  --branch develop

# Step 4: Implement frontend
/implement-frontend @ANALYSIS_USER_PROFILE.md \
  --repo /path/to/frontend \
  --backend-pr 123

# Step 5: Validate implementation
/validate-feature @ANALYSIS_USER_PROFILE.md \
  --pr 124 \
  --repo /path/to/backend
```

### Code Review Workflow

```bash
# Quick review
/review-pr owner/repo#123

# Deep review with all specialists
/deep-review owner/repo#123

# Batch review multiple PRs
/review-pr-batch owner/backend#40 owner/frontend#26 owner/frontend#27
```

### Bug Fixing Workflow

```bash
# From a bug document
/fix-bug @BUG_DUPLICATE_EMAILS.md \
  --repo /path/to/backend \
  --branch develop

# From inline description
/fix-bug "Users receive duplicate welcome emails" \
  --repo /path/to/backend
```

## More Examples

- [Feature Development](feature-development.md) - Complete feature workflow
- [Code Review](code-review.md) - Review patterns and practices
- [Debugging](debugging.md) - Bug fixing workflows
