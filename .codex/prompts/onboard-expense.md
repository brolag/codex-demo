---
description: Interactive onboarding + setup checklist for Expense Tracker (Codex)
argument-hint: "[MODE=full|quick]"
---

# Expense Tracker Onboarding (Codex)

Guide a new developer through repo setup and Codex conventions. Be interactive: ask brief questions, wait for answers, and keep a running checklist with statuses.

## Interaction Rules
- Start with a one-line welcome and ask what they have done so far (or if they want quick vs full run-through).
- Move through sections in order: Prereqs → Backend → Frontend → Codex/Ralph basics → Validation.
- For each checklist item, ask Y/N/skip; mark it as `Ready`, `Missing`, or `Skipped`.
- After each section, show a short status list and suggest the exact command for any missing item.
- Keep responses concise; avoid long paragraphs. End with a condensed summary of remaining steps.

## Checklist Items
### Prereqs
- Python 3.10+ and `pip`
- Node.js 18+ and `npm`
- Git and Bash/zsh available for scripts

### Backend Setup (`backend/`)
- Virtualenv created and activated (e.g., `python3 -m venv venv && source venv/bin/activate`)
- Dependencies installed: `cd backend && pip install -r requirements.txt`
- Dev server ready: `cd backend && uvicorn main:app --reload --port 8000`
- Tests run once: `cd backend && pytest -v`

### Frontend Setup (`frontend/`)
- Dependencies installed: `cd frontend && npm install`
- Dev server ready: `cd frontend && npm run dev` (http://localhost:5173)
- API URL verified (defaults to http://localhost:8000; override in `frontend/.env` if needed)

### Codex & Ralph Config
- Read `prd.json`, `progress.txt`, and `AGENTS.md`
- Rules understood: one feature per iteration, backend first, remove test skips, run `cd backend && pytest -v`, update `progress.txt`
- Loop prompt: `.codex/prompts/ralph-expense.md`
- Scripts: `./scripts/codex-ralph-once.sh` (HITL) and `./scripts/codex-afk-ralph.sh <max>` (AFK)

### Validation
- Backend responds at `GET /health`
- Frontend renders and can create/list an expense

## Output Format
- Use bullet checklist with prefixes `[Ready]`, `[Missing]`, `[Skipped]`; include the command next to missing items.
- Conclude with 3 bullets: what’s ready, what to do next, and a tip to keep `prd.json`/`progress.txt` open while working.
