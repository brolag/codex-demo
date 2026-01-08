#!/bin/bash
# Ralph Once - Human-in-the-loop single iteration (Claude Code)
# Usage: ./scripts/ralph-once.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Ralph Once - Single Iteration (Claude)${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if claude is available
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}Warning: claude CLI not found${NC}"
    echo "Install with: curl -fsSL https://claude.ai/install.sh | bash"
    echo "Or: npm i -g @anthropic-ai/claude-code"
    exit 1
fi

echo -e "${GREEN}Running single iteration...${NC}"
echo ""

claude --permission-mode acceptEdits "@prd.json @progress.txt @AGENTS.md
YOUR TASK:
1. Read prd.json to see features with passes: false
2. Read progress.txt to see what was done before
3. Pick ONE feature to implement (highest priority first)
4. Implement it fully (backend + frontend if needed)
5. Remove @pytest.mark.skip from its tests
6. Run tests: cd backend && pytest -v
7. Update progress.txt with what you did
8. If ALL features are complete, output: <promise>COMPLETE</promise>

RULES:
- ONLY work on ONE feature per iteration
- Always run tests after changes
- Update progress.txt before finishing
- Prioritize: architectural work > integration > features > polish
"

echo ""
echo -e "${BLUE}Iteration complete. Review changes and run again if needed.${NC}"
