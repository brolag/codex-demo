#!/bin/bash
# Ralph Once - Human-in-the-loop single iteration (Claude Code)
# Usage: ./scripts/ralph-once.sh

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
echo -e "${BLUE}  Ralph Once - Single Iteration (Claude)${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Prompt: ${YELLOW}${PROMPT_PATH}${NC}"
echo -e "Test command: ${YELLOW}${TEST_CMD}${NC}"
echo ""

# Check if claude is available
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}Warning: claude CLI not found${NC}"
    echo "Install with: curl -fsSL https://claude.ai/install.sh | bash"
    echo "Or: npm i -g @anthropic-ai/claude-code"
    exit 1
fi

if [[ ! -f "$PROMPT_PATH" ]]; then
    echo -e "${YELLOW}Prompt file not found:${NC} $PROMPT_PATH"
    exit 1
fi

echo -e "${GREEN}Running single iteration with Claude using ralph-expense prompt...${NC}"
echo ""

claude --permission-mode acceptEdits "@prd.json @progress.txt @AGENTS.md @$PROMPT_PATH

MODE=once
TEST_CMD=\"$TEST_CMD\"

Follow the instructions in the ralph-expense prompt above with MODE=once.
"

echo ""
echo -e "${BLUE}Iteration complete. Review changes and run again if needed.${NC}"
