Test feature implementation: $ARGUMENTS

## Instructions

Perform comprehensive testing of a feature implementation.

### Arguments

Format: `<analysis_doc> --repo <repo_path> [--branch <feature_branch>] [--focus <unit|integration|e2e|all>]`

Example:
```
@ANALYSIS_FEATURE.md --repo /path/to/backend --branch feature/extra-usage --focus all
```

Defaults: `--branch current`, `--focus all`

### Step 1: Setup

```bash
cd <repo_path>
git checkout <feature_branch>
docker-compose up -d
```

### Step 2: Analyze Implementation

1. Read analysis document for expected behavior
2. List modified files: `git diff develop --name-only`
3. Identify test coverage needs

### Step 3: Test Strategy

| Focus | What to Test |
|-------|--------------|
| unit | Service methods, utilities, validation |
| integration | API endpoints, DB interactions |
| e2e | Complete user flows |
| all | All of the above |

### Step 4: Create Tests

Follow existing test patterns in the repository.

```python
class TestFeature:
    async def test_happy_path(self, db_session, test_user):
        """Feature works with valid input."""
        result = await service.method(test_user.id, valid_data)
        assert result.success is True
    
    async def test_edge_case(self, db_session, test_user):
        """Handle edge case gracefully."""
        result = await service.method(test_user.id, edge_data)
        assert result.error_code == "expected_error"
```

### Step 5: Run Tests

```bash
# All feature tests
docker-compose exec api pytest tests/ -v -k "feature_name"

# With coverage
docker-compose exec api pytest tests/ -k "feature_name" --cov=app/services/feature --cov-report=term-missing
```

Target: **80%+ coverage** for new code

### Step 6: Fix Bugs Found

1. Write failing test first
2. Fix the code minimally
3. Verify test passes
4. Run full suite

### Output

1. **Tests Created**: Unit (X), Integration (X)
2. **Coverage**: Service (X%), API (X%)
3. **Bugs Found**: [list with fixes]
4. **Test Commands**: How to run
5. **Recommendations**: Additional testing needed
