#!/bin/bash
# Ralph Wiggum Pattern - Expense Tracker Demo
# Autonomous coding loop for Codex CLI

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

MAX_ITERATIONS=${1:-10}
PROMISE_TEXT="COMPLETE"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Ralph Wiggum Loop - Expense Tracker  ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Max iterations: ${YELLOW}$MAX_ITERATIONS${NC}"
echo -e "Exit promise: ${GREEN}<promise>$PROMISE_TEXT</promise>${NC}"
echo ""

# Check if codex is available
if ! command -v codex &> /dev/null; then
    echo -e "${RED}Error: codex CLI not found${NC}"
    echo "Install with: npm install -g @openai/codex"
    exit 1
fi

# Main loop
for ((i=1; i<=$MAX_ITERATIONS; i++)); do
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  Iteration $i of $MAX_ITERATIONS${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Run Codex with the task
    result=$(codex exec "
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
" --approval-mode full-auto 2>&1) || true

    echo "$result"
    echo ""

    # Check for completion promise
    if echo "$result" | grep -q "<promise>$PROMISE_TEXT</promise>"; then
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}  SUCCESS! All features implemented!${NC}"
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        exit 0
    fi

    # Check test results
    echo -e "${BLUE}Running tests...${NC}"
    cd backend
    if pytest -v 2>&1 | tee /dev/stderr | grep -q "passed"; then
        echo -e "${GREEN}Tests passed!${NC}"
    else
        echo -e "${YELLOW}Some tests still failing - continuing...${NC}"
    fi
    cd ..

    echo ""
    sleep 2
done

echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Max iterations reached ($MAX_ITERATIONS)${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Check progress.txt for current status"
exit 1
