# Research Assistant Skill for Bob

A comprehensive Bob skill that streamlines research workflows through automated document conversion, web scraping, analysis, and professional report generation.

## 🚀 Quick Start

### Installation

```bash
# Clone this repository
git clone <repo-url>
cd bob-research-assistant-skill

# Run the installer (installs dependencies and skill globally)
./install.sh
```

Or install manually:

```bash
# 1. Install prerequisites
pip install docling crawl4ai
brew install pandoc  # macOS (or apt-get/choco for Linux/Windows)

# 2. Copy skill to Bob's global skills directory
cp -r .bob/skills/research-assistant ~/.bob/skills/
```

> **Note:** `./install.sh` copies the skill to `~/.bob/skills/research-assistant` — Bob's **global** skills directory. Once installed, the skill is available in every Bob session, in any folder or workspace. You do not need to keep this repo open or work inside it.

### Using the Skill

After installation, open Bob in **any project folder** and start asking:

```
You: "Research the competitive landscape for AI API gateways"
You: "Convert this PDF to markdown"
You: "Scrape https://example.com and summarise it"
```

Bob activates the Research Assistant skill automatically. Your research project files are created in whatever working directory you have open — they are completely independent of this repository.

Optionally, copy the utility scripts to a location on your `$PATH` so you can run them from anywhere:

```bash
# Optional: make scripts available system-wide
cp .bob/skills/research-assistant/scripts/*.sh ~/bin/
chmod +x ~/bin/*.sh

# Then from any research project folder:
init-research-project.sh my-project
batch-convert-pdfs.sh sources/raw sources
search-sources.sh "API Gateway"
```

## 📚 What This Skill Does

The Research Assistant skill enables Bob to help you with:

- **📄 Document Conversion**: Transform PDFs, Word docs, and PowerPoint files into clean markdown
- **🌐 Web Scraping**: Extract and convert web content into structured markdown
- **🔍 Research Analysis**: Conduct literature reviews, competitive analysis, trend analysis, and gap analysis
- **📊 Report Generation**: Create professional Word documents and PDFs from your research
- **📁 Source Management**: Organize and track research materials systematically
- **🔗 Citation Management**: Track sources and maintain bibliographies
- **📦 Batch Operations**: Process multiple documents efficiently
- **🧠 Persistent Wiki**: LLM-maintained knowledge base that compounds across sessions, with human-in-the-loop inbox review before anything is written to the wiki

## 🎯 Use Cases

### For Researchers
- Synthesize academic papers and industry reports
- Track trends across multiple sources
- Generate literature reviews automatically

### For Business Analysts
- Competitive intelligence gathering
- Market research and analysis
- Executive briefing generation

### For Product Managers
- Technology assessment and vendor evaluation
- Feature comparison across competitors
- Strategic planning documentation

## 💡 Example Workflows

### Convert a Research Paper
```
You: "Convert the Gartner API Management report to markdown"
Bob: ✓ Converted and saved to sources/Gartner/api-management-2024.md
```

### Conduct Competitive Analysis
```
You: "Compare Kong, Apigee, and MuleSoft API gateways"
Bob: ✓ Analyzed 15 sources
     ✓ Created comparison matrix
     ✓ Generated report: output/api-gateway-comparison.docx
```

### Generate Executive Summary
```
You: "Create an executive summary from my API trends research"
Bob: ✓ Synthesized findings from 8 sources
     ✓ Generated: output/api-trends-executive-brief.docx
```

## 📖 Documentation

### 📚 Main Documentation

#### Project Root
- **[README.md](README.md)** - This file: project overview, installation, and quick start
- **[SHARING.md](SHARING.md)** - Distribution and sharing guide (520 lines)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines (467 lines)
- **[install.sh](install.sh)** - Installation script (242 lines)

#### Utility Scripts
- **[scripts/README.md](scripts/README.md)** - Script documentation (437 lines)
- **[scripts/](scripts/)** - 13 automation scripts (2,369 lines total)

### 🎯 Skill Documentation

#### Core Files
- **[SKILL.md](.bob/skills/research-assistant/SKILL.md)** - Skill definition for Bob
- **[README.md](.bob/skills/research-assistant/README.md)** - Complete user guide (738 lines)

#### Guides (10 files)
1. **[Batch Operations](.bob/skills/research-assistant/guides/batch-operations.md)** - Bulk processing workflows
2. **[Citation Management](.bob/skills/research-assistant/guides/citation-management.md)** - Source tracking and bibliographies
3. **[Common Commands](.bob/skills/research-assistant/guides/common-commands.md)** - CLI command reference
4. **[Conversation Flows](.bob/skills/research-assistant/guides/conversation-flows.md)** - User interaction patterns
5. **[Diagram Creation](.bob/skills/research-assistant/guides/diagram-creation.md)** - Mermaid.js diagrams (586 lines)
6. **[Error Handling](.bob/skills/research-assistant/guides/error-handling.md)** - Troubleshooting and recovery
7. **[Project Initialization](.bob/skills/research-assistant/guides/project-initialization.md)** - Setting up projects
8. **[Quality Assurance](.bob/skills/research-assistant/guides/quality-assurance.md)** - Validation and quality metrics
9. **[Source Organization](.bob/skills/research-assistant/guides/source-organization.md)** - Managing research materials
10. **[Version Control](.bob/skills/research-assistant/guides/version-control.md)** - Managing research iterations

#### Templates (5 files)
1. **[Competitive Analysis](.bob/skills/research-assistant/templates/competitive-analysis.md)**
2. **[Executive Summary](.bob/skills/research-assistant/templates/executive-summary.md)**
3. **[Literature Review](.bob/skills/research-assistant/templates/literature-review.md)**
4. **[Research Report](.bob/skills/research-assistant/templates/research-report.md)**
5. **[Technical Deep Dive](.bob/skills/research-assistant/templates/technical-deep-dive.md)**

#### Examples (6 directories, 20+ files)
1. **[Document Conversion](.bob/skills/research-assistant/examples/document-conversion/)** - PDF/DOCX conversion
2. **[Web Scraping](.bob/skills/research-assistant/examples/web-scraping/)** - Content extraction
3. **[Research Analysis](.bob/skills/research-assistant/examples/research-analysis/)** - Analysis methodologies
4. **[Report Generation](.bob/skills/research-assistant/examples/report-generation/)** - Creating deliverables
5. **[Folder Management](.bob/skills/research-assistant/examples/folder-management/)** - Project organization
6. **[User Interaction](.bob/skills/research-assistant/examples/user-interaction/)** - Complete workflows

### 🔗 Quick Links by Audience

#### For End Users
- [Installation Guide](#installation)
- [Quick Start](#quick-start)
- [Skill Documentation](.bob/skills/research-assistant/README.md)
- [Troubleshooting](.bob/skills/research-assistant/README.md#troubleshooting)

#### For Contributors
- [Contributing Guidelines](CONTRIBUTING.md)
- [Development Workflow](#for-contributors)
- [Script Documentation](scripts/README.md)

#### For Sharing
- [Sharing Guide](SHARING.md)
- [Installation Script](install.sh)
- [Distribution Options](SHARING.md#distribution-options)

## 🛠️ Prerequisites

### Required Tools

1. **docling** - Document conversion
   ```bash
   pip install docling
   ```

2. **crawl4ai** - Web scraping
   ```bash
   pip install crawl4ai
   ```

3. **pandoc** - Report generation
   ```bash
   # macOS
   brew install pandoc
   
   # Linux
   apt-get install pandoc
   
   # Windows
   choco install pandoc
   ```

4. **mermaid-cli** - Diagram generation (optional but recommended)
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

### Recommended Tools

1. **VS Code Mermaid Extension** - For diagram editing
   - Install: [Mermaid Preview](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)
   - Enables live preview of Mermaid diagrams in markdown files
   - Essential for creating and editing diagrams in research documents

### System Requirements
- Python 3.8 or higher
- Node.js 14+ (for mermaid-cli)
- 2GB free disk space
- Internet connection (for web scraping)

## 📁 Project Structure

```
.bob/skills/research-assistant/
├── SKILL.md                    # Skill definition for Bob
├── README.md                   # Complete user documentation (738 lines)
├── examples/                   # 20+ practical examples
│   ├── document-conversion/    # PDF, DOCX, PPTX conversion
│   ├── web-scraping/          # Web content extraction
│   ├── research-analysis/     # 4 analysis methodologies
│   ├── report-generation/     # Professional report creation
│   ├── folder-management/     # Project organization
│   └── user-interaction/      # Complete workflow examples
├── templates/                  # 5 report templates (2,035 lines)
│   ├── literature-review.md
│   ├── competitive-analysis.md
│   ├── executive-summary.md
│   ├── research-report.md
│   └── technical-deep-dive.md
└── guides/                     # 9 comprehensive guides
    ├── batch-operations.md
    ├── citation-management.md
    ├── common-commands.md
    ├── conversation-flows.md
    ├── error-handling.md
    ├── project-initialization.md
    ├── quality-assurance.md
    ├── source-organization.md
    └── version-control.md
```

## 🎓 Learning Path

1. **Start Here**: [Skill README](.bob/skills/research-assistant/README.md)
2. **Try Examples**: [Document Conversion](.bob/skills/research-assistant/examples/document-conversion/)
3. **Learn Workflows**: [Research Analysis](.bob/skills/research-assistant/examples/research-analysis/)
4. **Master Advanced**: [Advanced Usage](.bob/skills/research-assistant/README.md#advanced-usage)

## 🔧 Development

### For Contributors

If you're actively developing this skill, you can update your local Bob installation after making changes:

```bash
# 1. Make changes to skill files
vim .bob/skills/research-assistant/SKILL.md

# 2. Reinstall to test changes
./install.sh  # Say 'y' to overwrite

# 3. Test with Bob (uses updated skill immediately)

# 4. Commit when satisfied
git add .
git commit -m "feat: Your changes"
```

**Quick Development Options:**

**Option 1: Reinstall after changes** (recommended for testing)
```bash
./install.sh  # Overwrites ~/.bob/skills/research-assistant/
```

**Option 2: Symlink for live development** (advanced)
```bash
# Remove installed version
rm -rf ~/.bob/skills/research-assistant

# Create symlink to your repo
ln -s $(pwd)/.bob/skills/research-assistant ~/.bob/skills/research-assistant

# Now edits are immediately live in Bob - no reinstall needed!
```

### Implementation Status

✅ **Phase 1-10 Complete** (5,000+ lines of documentation)
- Core skill structure
- Document conversion workflows
- Web scraping workflows
- Research analysis patterns
- Report generation
- Folder management
- User interaction patterns
- Advanced features
- Quality assurance
- Complete documentation

### Future Enhancements

**Phase 11: Multimedia Transcription** (Planned)
- Video/audio transcription using yt-dlp, ffmpeg, and whisper.cpp
- Conference talk and podcast processing
- Local, privacy-friendly transcription

**Phase 12: Presentation Generation** (Planned)
- Marp-based presentation creation
- Export to PPTX, PDF, HTML
- Professional themes and templates

See [IMPLEMENTATION_ROADMAP.md](IMPLEMENTATION_ROADMAP.md) for details.

## 📊 Documentation Statistics

### Totals
- **Total Files**: 50+ markdown files
- **Total Lines**: 8,000+ lines of documentation
- **Guides**: 10 comprehensive guides
- **Templates**: 5 report templates (2,035 lines)
- **Examples**: 20+ practical examples
- **Scripts**: 13 utility scripts (2,369 lines)
- **Main Docs**: 3 files (README, SHARING, CONTRIBUTING - 1,424 lines)

### By Category
- **Skill Documentation**: 5,000+ lines
- **Project Documentation**: 1,424 lines
- **Utility Scripts**: 2,369 lines
- **Script Documentation**: 437 lines

## 🤝 Contributing

We welcome contributions from team members! See **[CONTRIBUTING.md](CONTRIBUTING.md)** for detailed guidelines.

**Quick Start for Contributors:**
1. Clone repository and install: `./install.sh`
2. Make changes to `.bob/skills/research-assistant/`
3. Reinstall to test: `./install.sh`
4. Commit and push: `git commit -m "feat: Your change"`

**What to Contribute:**
- New templates and examples
- Utility scripts and automation
- Documentation improvements
- Bug fixes and enhancements

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete guidelines, code style, and submission process.

## 📄 License

Part of the Bob AI assistant framework.

## 🔗 Related Documentation

- **[PLAN.md](PLAN.md)** - Original design and architecture
- **[IMPLEMENTATION_ROADMAP.md](IMPLEMENTATION_ROADMAP.md)** - Detailed implementation guide
- **[SUMMARY.md](SUMMARY.md)** - Executive overview
- **[PHASE_10_VERIFICATION.md](PHASE_10_VERIFICATION.md)** - Implementation verification

---

**Ready to streamline your research workflow?** Start with the [Skill Documentation](.bob/skills/research-assistant/README.md)!