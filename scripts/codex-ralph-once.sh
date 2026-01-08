#!/bin/bash
# Codex Ralph Once - Human-in-the-loop single iteration (Codex CLI)
# Usage: ./scripts/codex-ralph-once.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Ralph Once - Single Iteration (Codex)${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if codex is available
if ! command -v codex &> /dev/null; then
    echo -e "${YELLOW}Warning: codex CLI not found${NC}"
    echo "Install with: npm install -g @openai/codex"
    exit 1
fi

echo -e "${GREEN}Running single iteration with Codex...${NC}"
echo ""

codex exec "
You are working on an Expense Tracker project.

@prd.json @progress.txt @AGENTS.md

YOUR TASK:
1. Read prd.json to see which features need implementation (passes: false)
2. Read progress.txt to see what was done before
3. Pick ONE feature to implement (you decide priority)
4. Implement it in the appropriate file(s)
5. Remove the @pytest.mark.skip decorator from its tests
6. Run tests: cd backend && pytest -v
7. Update progress.txt with what you did
8. If ALL features are complete, output: <promise>COMPLETE</promise>

RULES:
- Only work on ONE feature per iteration
- Always run tests after changes
- Update progress.txt before finishing

Current directory: $(pwd)
" --approval-mode full-auto

echo ""
echo -e "${BLUE}Iteration complete. Review changes and run again if needed.${NC}"
