# Expense Tracker - Agent Instructions

## Project Overview
This is a simple expense tracker with:
- **Backend**: Python FastAPI API at `backend/main.py`
- **Frontend**: React app at `frontend/src/App.jsx`
- **Tests**: Pytest tests at `backend/test_main.py`

## Quality Rules

### Before Starting
1. Read `prd.json` to understand what features need implementation
2. Read `progress.txt` to see what was done in previous iterations
3. Check which tests are currently skipped (need implementation)

### Implementation Rules
1. **One feature per iteration** - Focus on a single feat-XXX
2. **Backend first** - Implement the API endpoint before frontend
3. **Remove test skips** - After implementing, remove `@pytest.mark.skip`
4. **Run tests** - Always run `cd backend && pytest -v` after changes
5. **Update progress.txt** - Log what you did

### Code Style
- Python: Follow PEP 8, use type hints
- React: Functional components, async/await for API calls
- Keep it simple - no over-engineering

### Testing
```bash
# Run all tests
cd backend && pytest -v

# Run specific test class
cd backend && pytest -v test_main.py::TestGetExpense
```

## Codex utilities
- Custom command: `codex custom onboard-expense` (usa `.codex/prompts/onboard-expense.md`) para guiar onboarding interactivo y checklist de setup/Codex/Ralph.
- Skill disponible: `action-doc-updater` en `.codex/skills/action-doc-updater/SKILL.md`; úsalo para mantener docs y logs al día después de cambios.

### Common Patterns

**Finding an expense by ID:**
```python
expense = next((e for e in expenses if e.id == expense_id), None)
if not expense:
    raise HTTPException(status_code=404, detail="Not found")
```

**Removing from list:**
```python
global expenses
expenses = [e for e in expenses if e.id != expense_id]
```

## Exit Condition
When all features have `passes: true` in prd.json, output:
```
<promise>COMPLETE</promise>
```
