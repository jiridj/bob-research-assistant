# Research Assistant Skill for Bob

A comprehensive Bob skill that streamlines research workflows through automated document conversion, web scraping, analysis, and professional report generation.

## 🚀 Quick Start

### Installation

```bash
# Clone this repository
git clone <repo-url>
cd bob-research-assistant-skill

# Run the installer (installs dependencies and skill)
./install.sh
```

Or install manually:

```bash
# 1. Install prerequisites
pip install docling crawl4ai
brew install pandoc  # macOS (or apt-get/choco for Linux/Windows)

# 2. Copy skill to Bob
cp -r .bob/skills/research-assistant ~/.bob/skills/

# 3. Make scripts executable
chmod +x scripts/*.sh
```

### Using the Skill

```bash
# Start using with Bob
# Bob will automatically use this skill when you ask for research assistance

# Or use utility scripts directly
./scripts/init-research-project.sh my-project
./scripts/batch-convert-pdfs.sh sources/raw sources
./scripts/search-sources.sh "API Gateway"
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

### Getting Started
- **[Skill Documentation](.bob/skills/research-assistant/README.md)** - Complete user guide with examples
- **[Quick Start Guide](.bob/skills/research-assistant/README.md#quick-start)** - Get up and running in minutes
- **[Prerequisites](.bob/skills/research-assistant/README.md#prerequisites)** - Installation instructions

### Workflows
- **[Document Conversion](.bob/skills/research-assistant/examples/document-conversion/)** - Convert PDFs, DOCX, PPTX
- **[Web Scraping](.bob/skills/research-assistant/examples/web-scraping/)** - Extract web content
- **[Research Analysis](.bob/skills/research-assistant/examples/research-analysis/)** - 4 analysis methodologies
- **[Report Generation](.bob/skills/research-assistant/examples/report-generation/)** - Create professional reports

### Resources
- **[Templates](.bob/skills/research-assistant/templates/)** - 5 report templates (2,000+ lines)
- **[Guides](.bob/skills/research-assistant/guides/)** - 9 comprehensive guides
- **[Examples](.bob/skills/research-assistant/examples/)** - 20+ practical examples
- **[Utility Scripts](scripts/README.md)** - 13 automation scripts
- **[Troubleshooting](.bob/skills/research-assistant/README.md#troubleshooting)** - Common issues and solutions

### Sharing
- **[Sharing Guide](SHARING.md)** - How to share this skill with others

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

### System Requirements
- Python 3.8 or higher
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

## 📊 Statistics

- **36 markdown files** with comprehensive documentation
- **5,000+ lines** of guides, examples, and templates
- **20+ practical examples** covering all workflows
- **5 report templates** for different use cases
- **9 detailed guides** for advanced usage
- **6 troubleshooting sections** with solutions

## 🤝 Contributing

This skill is part of the Bob AI assistant framework. For issues or suggestions:

1. Review the [documentation](.bob/skills/research-assistant/README.md)
2. Check [troubleshooting](.bob/skills/research-assistant/README.md#troubleshooting)
3. Consult [examples](.bob/skills/research-assistant/examples/)

## 📄 License

Part of the Bob AI assistant framework.

## 🔗 Related Documentation

- **[PLAN.md](PLAN.md)** - Original design and architecture
- **[IMPLEMENTATION_ROADMAP.md](IMPLEMENTATION_ROADMAP.md)** - Detailed implementation guide
- **[SUMMARY.md](SUMMARY.md)** - Executive overview
- **[PHASE_10_VERIFICATION.md](PHASE_10_VERIFICATION.md)** - Implementation verification

---

**Ready to streamline your research workflow?** Start with the [Skill Documentation](.bob/skills/research-assistant/README.md)!