---
description: Project-local Ralph loop for Expense Tracker (backend-first)
argument-hint: [MODE=once|afk] [MAX=<iterations>] [TEST_CMD="cd backend && pytest -v"]
---

# Ralph - Expense Tracker

Run a Ralph iteration tailored to this repo.

## Required context
- @prd.json
- @progress.txt
- @AGENTS.md

## Task
1. Read prd.json to find features with `passes: false`
2. Read progress.txt to see prior work
3. Pick **one** feature to implement (backend first, then frontend if required)
4. Remove any `@pytest.mark.skip` tied to that feature's tests
5. Run tests: `${TEST_CMD:-cd backend && pytest -v}`
6. Update prd.json if you mark the feature complete (set `passes: true`)
7. Append what you did to progress.txt under Iteration Log
8. If all features are complete, output `<promise>COMPLETE</promise>`

## Modes
- `MODE=once`: run `./scripts/codex-ralph-once.sh`
- `MODE=afk`: run `./scripts/codex-afk-ralph.sh ${MAX:-10}`

## Rules
- One feature per iteration
- Follow AGENTS.md guidance and keep changes focused
- Do not spawn recursive Codex/Ralph loops
