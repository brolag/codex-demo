#!/bin/bash
# Ralph Wiggum Pattern - Expense Tracker Demo
# Wrapper for the Codex AFK loop using the project prompt

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PROMPT_PATH="${PROMPT_PATH:-.codex/prompts/ralph-expense.md}"
export PROMPT_PATH

exec "$SCRIPT_DIR/scripts/codex-afk-ralph.sh" "$@"
