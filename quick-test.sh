#!/bin/bash
# quick-test.sh - Run essential tests for Research Assistant skill

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Research Assistant Quick Test${NC}"
echo "================================"
echo ""

PASSED=0
FAILED=0

# Test function
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -n "Testing $test_name... "
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((FAILED++))
        return 1
    fi
}

# Test 1: Installation files exist
run_test "installation files" "[ -f install.sh ] && [ -f README.md ]"

# Test 2: Skill directory structure
run_test "skill directory" "[ -d .bob/skills/research-assistant ]"

# Test 3: Skill definition
run_test "skill definition" "[ -f .bob/skills/research-assistant/SKILL.md ]"

# Test 4: Documentation files
run_test "documentation" "[ -f .bob/skills/research-assistant/README.md ] && [ -d .bob/skills/research-assistant/guides ]"

# Test 5: Scripts directory
run_test "scripts directory" "[ -d .bob/skills/research-assistant/scripts ] && [ -f .bob/skills/research-assistant/scripts/README.md ]"

# Test 6: Essential scripts exist
run_test "essential scripts" "[ -f .bob/skills/research-assistant/scripts/init-research-project.sh ] && [ -f .bob/skills/research-assistant/scripts/batch-convert-pdfs.sh ]"

# Test 7: Script permissions
run_test "script permissions" "[ -x .bob/skills/research-assistant/scripts/init-research-project.sh ]"

# Test 8: Templates exist
run_test "templates" "[ -d .bob/skills/research-assistant/templates ] && [ -f .bob/skills/research-assistant/templates/competitor-analysis.md ]"

# Test 9: Examples exist
run_test "examples" "[ -d .bob/skills/research-assistant/examples ]"

# Test 10: Python availability
run_test "Python 3" "which python3"

# Test 11: Git availability
run_test "Git" "which git"

# Test 12: Distribution files
run_test "distribution files" "[ -f SHARING.md ] && [ -f CONTRIBUTING.md ]"

# Test 13: Test plan
run_test "test plan" "[ -f TEST_PLAN.md ]"

# Test 15: Guide count
GUIDE_COUNT=$(find .bob/skills/research-assistant/guides -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
run_test "guide count (10)" "[ $GUIDE_COUNT -eq 10 ]"

# Test 16: Script count (12 utility scripts, quick-test.sh is in root)
SCRIPT_COUNT=$(find .bob/skills/research-assistant/scripts -name "*.sh" -type f 2>/dev/null | wc -l | tr -d ' ')
run_test "script count (12)" "[ $SCRIPT_COUNT -eq 12 ]"

# Test 17: Template count
TEMPLATE_COUNT=$(find .bob/skills/research-assistant/templates -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
run_test "template count (7)" "[ $TEMPLATE_COUNT -eq 7 ]"

echo ""
echo "================================"
echo -e "Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Run full test plan: See TEST_PLAN.md"
    echo "2. Test with Bob: Open Bob and try the skill"
    echo "3. Test installation: ./install.sh"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    echo ""
    echo "Please review the failures above and:"
    echo "1. Check file structure"
    echo "2. Verify all files are present"
    echo "3. Run: git status"
    exit 1
fi
