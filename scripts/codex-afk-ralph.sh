#!/bin/bash
# Codex AFK Ralph - Away-from-keyboard autonomous loop (Codex CLI)
# Usage: ./scripts/codex-afk-ralph.sh <iterations>
# Example: ./scripts/codex-afk-ralph.sh 10

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

MAX_ITERATIONS=${1:-10}
PROMISE_TEXT="COMPLETE"
LOG_FILE="codex-ralph-session-$(date +%Y%m%d-%H%M%S).log"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}      AFK Ralph Loop (Codex CLI)       ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Max iterations: ${YELLOW}$MAX_ITERATIONS${NC}"
echo -e "Exit promise: ${GREEN}<promise>$PROMISE_TEXT</promise>${NC}"
echo -e "Log file: ${CYAN}$LOG_FILE${NC}"
echo ""

# Check if codex is available
if ! command -v codex &> /dev/null; then
    echo -e "${RED}Error: codex CLI not found${NC}"
    echo "Install with: npm install -g @openai/codex"
    exit 1
fi

# Log start
echo "Codex Ralph AFK Session Started: $(date)" | tee "$LOG_FILE"
echo "Max Iterations: $MAX_ITERATIONS" | tee -a "$LOG_FILE"
echo "---" | tee -a "$LOG_FILE"

# Main loop
for ((i=1; i<=$MAX_ITERATIONS; i++)); do
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  Iteration $i of $MAX_ITERATIONS${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    echo "--- Iteration $i ---" | tee -a "$LOG_FILE"

    # Run Codex with full-auto mode
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
7. Update prd.json - set passes: true for completed feature
8. Update progress.txt with what you did
9. If ALL features are complete, output: <promise>COMPLETE</promise>

RULES:
- Only work on ONE feature per iteration
- Always run tests after changes
- Update both prd.json and progress.txt before finishing

Current directory: $(pwd)
" --approval-mode full-auto 2>&1) || true

    echo "$result" | tee -a "$LOG_FILE"
    echo ""

    # Check for completion promise
    if echo "$result" | grep -q "<promise>$PROMISE_TEXT</promise>"; then
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}  SUCCESS! All features implemented!    ${NC}"
        echo -e "${GREEN}  Completed in $i iteration(s)          ${NC}"
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo "COMPLETED at iteration $i: $(date)" | tee -a "$LOG_FILE"
        exit 0
    fi

    echo "Completed iteration $i: $(date)" | tee -a "$LOG_FILE"
    sleep 2
done

echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Max iterations reached ($MAX_ITERATIONS)  ${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Check progress.txt for current status"
echo "MAX_ITERATIONS reached: $(date)" | tee -a "$LOG_FILE"
exit 1
