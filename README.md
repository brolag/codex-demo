# Expense Tracker - Ralph Wiggum Pattern Demo

Demo project for teaching the **Ralph Wiggum autonomous coding loop** pattern with **Codex CLI**.

## What is Ralph Wiggum?

An autonomous AI coding pattern by Matt Pocock where:
1. **The agent picks the task** - Not you
2. **progress.txt is memory** - Persists between iterations
3. **Promise-based exit** - `<promise>COMPLETE</promise>` signals done
4. **Small steps** - One feature per iteration

## Project Structure

```
codex-loop-demo/
├── backend/              # Python FastAPI API
│   ├── main.py          # API endpoints (some TODO)
│   ├── test_main.py     # Pytest tests
│   └── requirements.txt
├── frontend/            # React + Vite
│   ├── src/
│   │   ├── App.jsx     # Main component
│   │   └── ...
│   └── package.json
├── prd.json             # Features tracking (passes: true/false)
├── progress.txt         # Inter-iteration memory
├── AGENTS.md            # Quality instructions for Codex
└── ralph.sh             # The loop script
```

## Features

| ID | Feature | Status |
|----|---------|--------|
| feat-001 | Create expense | Done |
| feat-002 | List expenses | Done |
| feat-003 | Get by ID | TODO |
| feat-004 | Update expense | TODO |
| feat-005 | Delete expense | TODO |
| feat-006 | Filter by category | TODO |
| feat-007 | Stats by category | TODO |

## Quick Start

### 1. Setup Backend
```bash
cd backend
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Setup Frontend
```bash
cd frontend
npm install
```

### 3. Run Manually (to test)
```bash
# Terminal 1 - Backend
cd backend && uvicorn main:app --reload

# Terminal 2 - Frontend
cd frontend && npm run dev
```

### 4. Run the Loop
```bash
# Make executable
chmod +x ralph.sh

# Run with max 10 iterations
./ralph.sh 10
```

## How the Loop Works

```
+---------------------------------------------+
|  ralph.sh starts iteration                  |
+----------------------+----------------------+
                       |
                       v
+---------------------------------------------+
|  Codex reads: prd.json, progress.txt        |
|  Picks ONE feature to implement             |
+----------------------+----------------------+
                       |
                       v
+---------------------------------------------+
|  Implements feature + removes test skip     |
|  Runs pytest                                |
+----------------------+----------------------+
                       |
                       v
+---------------------------------------------+
|  Updates progress.txt                       |
|  If all done: <promise>COMPLETE</promise>   |
+----------------------+----------------------+
                       |
          +------------+------------+
          |                         |
          v                         v
     [COMPLETE]              [Next iteration]
```

## Key Files

### prd.json
```json
{
  "features": [
    { "id": "feat-001", "title": "Create expense", "passes": true },
    { "id": "feat-003", "title": "Get by ID", "passes": false }
  ]
}
```
- `passes: true` = implemented and tests pass
- `passes: false` = needs implementation

### progress.txt
```
## Iteration 3
- Implemented feat-003 (get by ID)
- Removed @pytest.mark.skip from TestGetExpense
- All tests passing
```

### AGENTS.md
Quality instructions that Codex follows (one feature at a time, run tests, etc.)

## Teaching Points

1. **Agent autonomy** - Codex decides what to work on
2. **State persistence** - progress.txt survives between iterations
3. **Structured exit** - Promise pattern for completion
4. **Test-driven** - Tests define "done"
5. **Small batches** - One feature per loop reduces errors

## Requirements

- Python 3.10+
- Node.js 18+
- Codex CLI (`npm install -g @openai/codex`)
