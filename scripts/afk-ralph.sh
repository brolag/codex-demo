#!/bin/bash
# AFK Ralph - Away-from-keyboard autonomous loop (Claude Code)
# Usage: ./scripts/afk-ralph.sh <iterations>
# Example: ./scripts/afk-ralph.sh 10

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PROMPT_PATH="${PROMPT_PATH:-.codex/prompts/ralph-expense.md}"
TEST_CMD="${TEST_CMD:-cd backend && pytest -v}"
MAX_ITERATIONS="${MAX:-${1:-10}}"
PROMISE_TEXT="COMPLETE"
LOG_FILE="ralph-session-$(date +%Y%m%d-%H%M%S).log"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}    AFK Ralph Loop (Claude Code)       ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Prompt: ${YELLOW}${PROMPT_PATH}${NC}"
echo -e "Max iterations: ${YELLOW}$MAX_ITERATIONS${NC}"
echo -e "Test command: ${YELLOW}${TEST_CMD}${NC}"
echo -e "Exit promise: ${GREEN}<promise>$PROMISE_TEXT</promise>${NC}"
echo -e "Log file: ${CYAN}$LOG_FILE${NC}"
echo ""

# Check if claude is available
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: claude CLI not found${NC}"
    echo "Install with: curl -fsSL https://claude.ai/install.sh | bash"
    exit 1
fi

if [[ ! -f "$PROMPT_PATH" ]]; then
    echo -e "${RED}Prompt file not found:${NC} $PROMPT_PATH"
    exit 1
fi

# Log start
echo "Ralph AFK Session Started: $(date)" | tee "$LOG_FILE"
echo "Max Iterations: $MAX_ITERATIONS" | tee -a "$LOG_FILE"
echo "Prompt: $PROMPT_PATH" | tee -a "$LOG_FILE"
echo "Test command: $TEST_CMD" | tee -a "$LOG_FILE"
echo "---" | tee -a "$LOG_FILE"

# Main loop
for ((i=1; i<=$MAX_ITERATIONS; i++)); do
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  Iteration $i of $MAX_ITERATIONS${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    echo "--- Iteration $i ---" | tee -a "$LOG_FILE"

    # Run Claude in print mode (-p) for non-interactive output
    result=$(claude -p --permission-mode acceptEdits "@prd.json @progress.txt @AGENTS.md @$PROMPT_PATH

MODE=afk
ITERATION=$i
MAX=$MAX_ITERATIONS
TEST_CMD=\"$TEST_CMD\"

Follow the instructions in the ralph-expense prompt above with MODE=afk.
" 2>&1) || true

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
