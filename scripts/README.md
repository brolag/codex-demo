# Ralph Scripts

Autonomous coding loop scripts for Claude Code and Codex CLI.

## Scripts

| Script | CLI | Mode | Description |
|--------|-----|------|-------------|
| `ralph-once.sh` | Claude | HITL | Single iteration, interactive |
| `afk-ralph.sh` | Claude | AFK | Autonomous loop |
| `codex-ralph-once.sh` | Codex | HITL | Single iteration, interactive |
| `codex-afk-ralph.sh` | Codex | AFK | Autonomous loop |

## Quick Start

### Human-in-the-Loop (HITL)
Watch what Ralph does, intervene when needed:

```bash
# Claude Code
./scripts/ralph-once.sh

# Codex CLI
./scripts/codex-ralph-once.sh
```

### Away-from-Keyboard (AFK)
Let Ralph work autonomously:

```bash
# Claude Code - 10 iterations max
./scripts/afk-ralph.sh 10

# Codex CLI - 10 iterations max
./scripts/codex-afk-ralph.sh 10
```

## How It Works

1. Ralph reads `prd.json` for tasks (`passes: false`)
2. Reads `progress.txt` for previous work
3. Picks ONE task to implement
4. Implements it, runs tests
5. Updates `prd.json` (`passes: true`)
6. Updates `progress.txt`
7. Repeats until all done or max iterations

Exit signal: `<promise>COMPLETE</promise>`

## Files Required

- `prd.json` - Product requirements with feature list
- `progress.txt` - Progress tracking between iterations
- `AGENTS.md` - Instructions for the AI agent

## Tips

1. **Start HITL** - Watch a few iterations first
2. **Small tasks** - Keep PRD items small and focused
3. **Feedback loops** - Tests must pass before marking complete
4. **Cap iterations** - Always set a max (10-50 typical)
5. **Docker sandbox** - Use for AFK safety

## Logs

AFK scripts create session logs:
- `ralph-session-YYYYMMDD-HHMMSS.log` (Claude)
- `codex-ralph-session-YYYYMMDD-HHMMSS.log` (Codex)

## Global Command

If using Neural Claude Code, use `/ralph` command:

```
/ralph         - Run single iteration
/ralph afk 10  - Run AFK loop
/ralph setup   - Initialize Ralph in a project
```
