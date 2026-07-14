#!/bin/bash
# Research Assistant Skill Uninstaller
# Removes the Bob Research Assistant skill and optionally uninstalls dependencies

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SKILL_NAME="research-assistant"
BOB_SKILLS_DIR="${HOME}/.bob/skills"
SKILL_DIR="${BOB_SKILLS_DIR}/${SKILL_NAME}"
BOB_MODES_FILE="${HOME}/.bob/custom_modes.yaml"
MODE_SLUG="research-assistant"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Research Assistant Skill Uninstaller for Bob            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Confirm uninstall
echo "This will remove:"
echo "  • Skill files:   ${SKILL_DIR}"
echo "  • Custom mode:   '${MODE_SLUG}' entry in ${BOB_MODES_FILE}"
echo ""
read -p "Continue with uninstall? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Uninstall cancelled"
    exit 0
fi
echo ""

# Remove skill files
print_status "Removing skill files..."
if [ -d "${SKILL_DIR}" ]; then
    rm -rf "${SKILL_DIR}"
    print_success "Removed ${SKILL_DIR}"
else
    print_warning "Skill directory not found at ${SKILL_DIR}, skipping"
fi

# Remove custom mode entry from ~/.bob/custom_modes.yaml
print_status "Removing custom mode..."
if [ -f "${BOB_MODES_FILE}" ]; then
    if grep -q "slug: ${MODE_SLUG}" "${BOB_MODES_FILE}" 2>/dev/null; then
        python3 - <<'PYEOF'
import sys, os, re

modes_file = os.path.expanduser("~/.bob/custom_modes.yaml")
slug = "research-assistant"

with open(modes_file) as f:
    existing = f.read()

updated = re.sub(
    r'  - slug: ' + re.escape(slug) + r'.*?(?=\n  - slug:|\Z)',
    '',
    existing,
    flags=re.DOTALL
).rstrip()

# If customModes: key is now empty, remove it too
if re.search(r'^customModes:\s*$', updated, re.MULTILINE):
    updated = re.sub(r'^customModes:\s*\n?', '', updated, flags=re.MULTILINE)

updated = updated.rstrip()
if updated:
    updated += "\n"

if updated:
    with open(modes_file, "w") as f:
        f.write(updated)
else:
    os.remove(modes_file)

print(f"Mode '{slug}' removed from {modes_file}")
PYEOF

        if [ $? -eq 0 ]; then
            print_success "Custom mode removed from ${BOB_MODES_FILE}"
        else
            print_error "Failed to remove custom mode"
        fi
    else
        print_warning "Custom mode '${MODE_SLUG}' not found in ${BOB_MODES_FILE}, skipping"
    fi
else
    print_warning "${BOB_MODES_FILE} not found, skipping"
fi

# Optionally uninstall Python/system dependencies
echo ""
echo "The following dependencies were installed by install.sh."
echo "They may be used by other tools — uninstalling is optional."
echo ""
read -p "Uninstall docling, crawl4ai, and pandoc? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Detect pip
    if command -v pip3 &> /dev/null; then
        PIP_CMD="pip3"
    elif command -v pip &> /dev/null; then
        PIP_CMD="pip"
    else
        print_warning "pip not found — skipping Python package removal"
        PIP_CMD=""
    fi

    if [ -n "$PIP_CMD" ]; then
        print_status "Uninstalling docling..."
        if $PIP_CMD uninstall -y docling 2>/dev/null; then
            print_success "docling removed"
        else
            print_warning "docling not installed or removal failed"
        fi

        print_status "Uninstalling crawl4ai..."
        if $PIP_CMD uninstall -y crawl4ai 2>/dev/null; then
            print_success "crawl4ai removed"
        else
            print_warning "crawl4ai not installed or removal failed"
        fi
    fi

    print_status "Uninstalling pandoc..."
    OS="$(uname -s)"
    case "${OS}" in
        Darwin*)
            if command -v brew &> /dev/null; then
                if brew uninstall pandoc 2>/dev/null; then
                    print_success "pandoc removed"
                else
                    print_warning "pandoc not installed via Homebrew or removal failed"
                fi
            else
                print_warning "Homebrew not found — remove pandoc manually"
            fi
            ;;
        Linux*)
            if sudo apt-get remove -y pandoc 2>/dev/null; then
                print_success "pandoc removed"
            else
                print_warning "pandoc removal failed — try: sudo apt-get remove pandoc"
            fi
            ;;
        *)
            print_warning "Please remove pandoc manually for your system"
            ;;
    esac
else
    print_warning "Skipping dependency removal"
fi

# Print completion
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Uninstall Complete                                      ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "The Research Assistant skill has been removed."
echo "Research data in your project folders is untouched."
echo ""
