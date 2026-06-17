#!/bin/bash
# Research Assistant Skill Installer
# Installs the Bob Research Assistant skill and all dependencies

set -e  # Exit on error

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

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Research Assistant Skill Installer for Bob              ║${NC}"
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

# Check if running on supported OS
print_status "Checking operating system..."
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS_TYPE=Linux;;
    Darwin*)    OS_TYPE=Mac;;
    CYGWIN*)    OS_TYPE=Cygwin;;
    MINGW*)     OS_TYPE=MinGw;;
    *)          OS_TYPE="UNKNOWN:${OS}"
esac

if [ "$OS_TYPE" = "UNKNOWN:${OS}" ]; then
    print_error "Unsupported operating system: ${OS}"
    exit 1
fi
print_success "Operating system: ${OS_TYPE}"

# Check Python installation
print_status "Checking Python installation..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    print_success "Python ${PYTHON_VERSION} found"
else
    print_error "Python 3 is not installed"
    echo "Please install Python 3.8 or higher from https://www.python.org/"
    exit 1
fi

# Check pip installation
print_status "Checking pip installation..."
if command -v pip3 &> /dev/null; then
    print_success "pip3 found"
    PIP_CMD="pip3"
elif command -v pip &> /dev/null; then
    print_success "pip found"
    PIP_CMD="pip"
else
    print_error "pip is not installed"
    echo "Please install pip: https://pip.pypa.io/en/stable/installation/"
    exit 1
fi

# Install docling
print_status "Installing docling..."
if command -v docling &> /dev/null; then
    print_warning "docling already installed, skipping"
else
    if $PIP_CMD install docling; then
        print_success "docling installed successfully"
    else
        print_error "Failed to install docling"
        exit 1
    fi
fi

# Install crawl4ai
print_status "Installing crawl4ai..."
if command -v crawl4ai &> /dev/null; then
    print_warning "crawl4ai already installed, skipping"
else
    if $PIP_CMD install crawl4ai; then
        print_success "crawl4ai installed successfully"
    else
        print_error "Failed to install crawl4ai"
        exit 1
    fi
fi

# Install pandoc
print_status "Installing pandoc..."
if command -v pandoc &> /dev/null; then
    PANDOC_VERSION=$(pandoc --version | head -1 | cut -d' ' -f2)
    print_warning "pandoc ${PANDOC_VERSION} already installed, skipping"
else
    case "${OS_TYPE}" in
        Mac)
            if command -v brew &> /dev/null; then
                print_status "Installing pandoc via Homebrew..."
                if brew install pandoc; then
                    print_success "pandoc installed successfully"
                else
                    print_error "Failed to install pandoc"
                    exit 1
                fi
            else
                print_error "Homebrew not found. Please install pandoc manually:"
                echo "  Visit: https://pandoc.org/installing.html"
                exit 1
            fi
            ;;
        Linux)
            print_status "Installing pandoc via apt-get..."
            if sudo apt-get update && sudo apt-get install -y pandoc; then
                print_success "pandoc installed successfully"
            else
                print_error "Failed to install pandoc"
                echo "Try manually: sudo apt-get install pandoc"
                exit 1
            fi
            ;;
        *)
            print_error "Please install pandoc manually for your system:"
            echo "  Visit: https://pandoc.org/installing.html"
            exit 1
            ;;
    esac
fi

# Create Bob skills directory if it doesn't exist
print_status "Setting up Bob skills directory..."
if [ ! -d "${BOB_SKILLS_DIR}" ]; then
    mkdir -p "${BOB_SKILLS_DIR}"
    print_success "Created ${BOB_SKILLS_DIR}"
else
    print_success "Bob skills directory exists"
fi

# Copy skill files
print_status "Installing Research Assistant skill..."
if [ -d "${SKILL_DIR}" ]; then
    print_warning "Skill already exists at ${SKILL_DIR}"
    read -p "Overwrite existing installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled"
        exit 0
    fi
    rm -rf "${SKILL_DIR}"
fi

# Copy skill directory
if [ -d ".bob/skills/${SKILL_NAME}" ]; then
    cp -r ".bob/skills/${SKILL_NAME}" "${SKILL_DIR}"
    print_success "Skill files copied to ${SKILL_DIR}"
else
    print_error "Skill files not found in .bob/skills/${SKILL_NAME}"
    exit 1
fi

# Make scripts executable
print_status "Making utility scripts executable..."
if [ -d "scripts" ]; then
    chmod +x scripts/*.sh
    print_success "Scripts are now executable"
fi

# Verify installation
print_status "Verifying installation..."
ERRORS=0

if ! command -v docling &> /dev/null; then
    print_error "docling not found in PATH"
    ERRORS=$((ERRORS + 1))
fi

if ! command -v crawl4ai &> /dev/null; then
    print_error "crawl4ai not found in PATH"
    ERRORS=$((ERRORS + 1))
fi

if ! command -v pandoc &> /dev/null; then
    print_error "pandoc not found in PATH"
    ERRORS=$((ERRORS + 1))
fi

if [ ! -f "${SKILL_DIR}/SKILL.md" ]; then
    print_error "Skill definition not found"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -eq 0 ]; then
    print_success "All dependencies verified"
else
    print_error "Installation completed with ${ERRORS} error(s)"
    exit 1
fi

# Print success message
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Installation Complete!                                  ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "The Research Assistant skill is now installed and ready to use."
echo ""
echo "Quick Start:"
echo "  1. Ask Bob: 'Convert this PDF to markdown'"
echo "  2. Ask Bob: 'Scrape this website for research'"
echo "  3. Ask Bob: 'Create a competitive analysis report'"
echo ""
echo "Documentation:"
echo "  ${SKILL_DIR}/README.md"
echo ""
echo "Utility Scripts:"
echo "  ./scripts/init-research-project.sh    - Create new research project"
echo "  ./scripts/batch-convert-pdfs.sh       - Convert multiple PDFs"
echo "  ./scripts/search-sources.sh           - Search research sources"
echo ""
echo "For more information, see: ${SKILL_DIR}/README.md"
echo ""

# Made with Bob
