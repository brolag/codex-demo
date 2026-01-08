#!/bin/bash
# Codex Ralph Once - Human-in-the-loop single iteration (Codex CLI)
# Usage: ./scripts/codex-ralph-once.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PROMPT_PATH="${PROMPT_PATH:-.codex/prompts/ralph-expense.md}"
TEST_CMD="${TEST_CMD:-cd backend && pytest -v}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Ralph Once - Single Iteration (Codex)${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Prompt: ${YELLOW}${PROMPT_PATH}${NC}"
echo -e "Test command: ${YELLOW}${TEST_CMD}${NC}"
echo ""

# Check if codex is available
if ! command -v codex &> /dev/null; then
    echo -e "${YELLOW}Warning: codex CLI not found${NC}"
    echo "Install with: npm install -g @openai/codex"
    exit 1
fi

if [[ ! -f "$PROMPT_PATH" ]]; then
    echo -e "${YELLOW}Prompt file not found:${NC} $PROMPT_PATH"
    exit 1
fi

echo -e "${GREEN}Running single iteration with Codex using ralph-expense prompt...${NC}"
echo ""

codex exec "
@prd.json @progress.txt @AGENTS.md @$PROMPT_PATH

MODE=once
TEST_CMD=\"$TEST_CMD\"

Follow the instructions in the ralph-expense prompt above with MODE=once.
" --approval-mode full-auto

echo ""
echo -e "${BLUE}Iteration complete. Review changes and run again if needed.${NC}"
