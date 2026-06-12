# Research Assistant Skill - Implementation Roadmap

## Phase 1: Core Skill Structure

### 1.1 Create Skill Directory
```
.bob/skills/research-assistant/
├── SKILL.md                    # Main skill definition
├── README.md                   # User documentation
├── examples/                   # Example workflows
│   ├── document-conversion/
│   ├── web-scraping/
│   ├── research-analysis/
│   └── report-generation/
├── templates/                  # Report templates
│   ├── literature-review.md
│   ├── competitive-analysis.md
│   ├── executive-summary.md
│   └── research-report.md
└── guides/                     # Detailed guides
    ├── cli-tools.md
    ├── workflows.md
    └── best-practices.md
```

### 1.2 SKILL.md Content Structure

```markdown
---
name: Research Assistant
description: Comprehensive research workflow automation with document conversion, web scraping, analysis, and report generation
---

# Research Assistant

You are a research assistant that streamlines the entire research workflow from document ingestion to final report generation.

## Core Capabilities

1. **Document Conversion** (via docling CLI)
2. **Web Scraping** (via crawl4ai CLI)
3. **Research Analysis & Synthesis**
4. **Report Generation** (via pandoc CLI)
5. **Source Organization & Discovery**

## Workflow Orchestration

[Detailed workflow patterns]

## CLI Tool Integration

[Tool-specific instructions]

## Research Methodologies

[Analysis patterns and templates]
```

## Phase 2: Document Conversion Workflows

### 2.1 Docling Integration

**Key Principles**:
- Images excluded by default
- Optional image export as separate reference files
- Never embed images as base64/encoded blobs
- Preserve document structure and formatting

**Command Patterns**:
```bash
# Basic conversion (no images)
docling input.pdf --output sources/[category]/document.md --no-images

# With image references
docling input.pdf \
  --output sources/[category]/document.md \
  --export-images sources/[category]/images/

# Batch processing
for file in sources/raw/*.pdf; do
  docling "$file" --output "sources/processed/$(basename "$file" .pdf).md" --no-images
done
```

**Workflow Steps**:
1. Identify document type (PDF, DOCX, PPTX)
2. Determine target category/folder
3. Check if images should be exported
4. Execute docling with appropriate flags
5. Verify output and organize files
6. Create metadata/index entry

### 2.2 Example Workflows

**Example 1: Convert Gartner Report**
```
User: "Convert the Gartner Magic Quadrant PDF to markdown"

Bob Actions:
1. Identify file location
2. Determine category (Gartner)
3. Execute: docling gartner-mq.pdf --output sources/Gartner/magic-quadrant-2024.md --no-images
4. Confirm successful conversion
5. Report location of output file
```

**Example 2: Convert with Image References**
```
User: "Convert the AWS whitepaper and keep the architecture diagrams"

Bob Actions:
1. Identify file location
2. Determine category (Hyperscalers/AWS)
3. Execute: docling aws-whitepaper.pdf \
   --output sources/Hyperscalers/AWS/whitepaper.md \
   --export-images sources/Hyperscalers/AWS/images/
4. Confirm conversion and image export
5. Report locations
```

## Phase 3: Web Scraping Workflows

### 3.1 Crawl4ai Integration

**Command Patterns**:
```bash
# Single page
crawl4ai https://example.com --output sources/web/page.md

# Multiple URLs from file
crawl4ai --urls urls.txt --output sources/web/

# With specific selectors
crawl4ai https://example.com \
  --selector "article.content" \
  --output sources/web/article.md
```

**Workflow Steps**:
1. Validate URL(s)
2. Determine target category
3. Execute crawl4ai with appropriate options
4. Analyze scraped content for relevant links
5. Suggest related pages to scrape (if applicable)
6. Clean and format output
7. Organize in sources folder
8. Create metadata entry

**Link Discovery**:
When scraping a single page, analyze the content for relevant internal links:
- Extract links from main content area
- Filter out navigation, footer, and sidebar links
- Identify related articles, documentation pages, or resources
- Present top 3-5 most relevant links to user
- Ask if they should be scraped as well

### 3.2 Example Workflows

**Example 1: Scrape Competitor Website**
```
User: "Scrape the Kong API Gateway features page"

Bob Actions:
1. Validate URL
2. Determine category (Competitors/Kong)
3. Execute: crawl4ai https://konghq.com/products/api-gateway \
   --output sources/Competitors/Kong/features.md
4. Verify content extraction
5. Analyze content for relevant links
6. Present discovered links:
   "I found these related pages that might be useful:
   - /products/api-gateway/pricing
   - /products/api-gateway/documentation
   - /products/api-gateway/use-cases
   
   Would you like me to scrape any of these as well?"
7. Report success
```

**Example 2: Scrape with Link Discovery**
```
User: "Scrape the AWS Lambda documentation page"

Bob Actions:
1. Validate URL
2. Determine category (Hyperscalers/AWS)
3. Execute: crawl4ai https://docs.aws.amazon.com/lambda/latest/dg/welcome.html \
   --output sources/Hyperscalers/AWS/lambda-intro.md
4. Extract relevant links from content:
   - Getting started guide
   - Best practices
   - Pricing details
   - Integration patterns
5. Ask: "I found 4 related documentation pages. Should I scrape them too?"
6. If yes, batch scrape related pages
7. Report all scraped files
```

## Phase 4: Research Analysis Patterns

### 4.1 Analysis Types

**Literature Review**:
- Synthesize multiple sources on a topic
- Identify key themes and patterns
- Extract main arguments and findings
- Create structured summary

**Competitive Analysis**:
- Compare competitor capabilities
- Create comparison matrices
- Identify strengths and weaknesses
- Generate strategic insights

**Trend Analysis**:
- Identify patterns across sources
- Track evolution over time
- Predict future directions
- Highlight emerging themes

**Gap Analysis**:
- Identify missing information
- Highlight research opportunities
- Suggest additional sources needed
- Prioritize investigation areas

### 4.2 Source Discovery Patterns

**Search Strategies**:
```bash
# Find all sources mentioning a topic
grep -r "API Gateway" sources/ --include="*.md"

# List sources by category
find sources/Gartner/ -name "*.md" -type f

# Recent additions
find sources/ -name "*.md" -mtime -7

# Full-text search with context
grep -r -C 3 "microservices" sources/
```

**Smart Discovery**:
1. User specifies research topic
2. Bob searches across all source folders
3. Ranks results by relevance
4. Presents top matches with context
5. User selects sources to include

### 4.3 Analysis Workflow

**Standard Research Process**:
1. **Define Scope**: Clarify research question/topic
2. **Discover Sources**: Find relevant materials
3. **Read & Extract**: Gather key information
4. **Synthesize**: Combine insights across sources
5. **Analyze**: Draw conclusions and identify patterns
6. **Document**: Create structured findings
7. **Review**: Validate completeness and accuracy

## Phase 5: Report Generation

### 5.1 Pandoc Integration

**Command Patterns**:
```bash
# Basic markdown to Word
pandoc report.md -o output/report.docx

# With reference template
pandoc report.md \
  --reference-doc=templates/corporate.docx \
  -o output/report.docx

# With table of contents
pandoc report.md \
  --toc \
  --toc-depth=3 \
  -o output/report.docx

# Multiple input files
pandoc intro.md findings.md conclusions.md \
  -o output/complete-report.docx
```

### 5.2 Report Templates

**Template Library**:
- `literature-review.md`: Academic-style review
- `competitive-analysis.md`: Business intelligence format
- `executive-summary.md`: Leadership brief
- `research-report.md`: Comprehensive research document
- `technical-deep-dive.md`: Detailed technical analysis

**Template Usage**:
1. User selects report type
2. Bob loads appropriate template
3. Populates with research findings
4. Formats according to template structure
5. Converts to Word using pandoc

## Phase 6: Folder Management

### 6.1 Project Initialization

**New Research Project**:
```bash
# Create project structure
mkdir -p research/[topic-name]
touch research/[topic-name]/notes.md
touch research/[topic-name]/analysis.md
touch research/[topic-name]/report.md
```

**Project Metadata**:
```markdown
# Research Project: [Topic Name]

**Created**: [Date]
**Status**: In Progress
**Sources Used**: 
- [List of source files]

**Research Questions**:
1. [Question 1]
2. [Question 2]

**Key Findings**:
[To be populated]
```

### 6.2 Source Organization

**Category Management**:
- Maintain consistent folder structure
- Use descriptive names
- Track source metadata
- Create index files for large categories

**Index File Example**:
```markdown
# Gartner Sources Index

## Reports
- `magic-quadrant-2024.md` - API Management MQ
- `market-guide-2024.md` - Integration Platforms

## Last Updated
2024-06-11

## Total Documents
15
```

## Phase 7: User Interaction Patterns

### 7.1 Common Commands

**Document Conversion**:
- "Convert [file] to markdown"
- "Process all PDFs in [folder]"
- "Convert [file] and export images"

**Web Scraping**:
- "Scrape [URL] to markdown"
- "Get content from [URL list]"
- "Extract [specific content] from [URL]"

**Research Tasks**:
- "Start research on [topic]"
- "Find sources about [topic]"
- "Analyze [sources] for [purpose]"
- "Compare [item A] and [item B]"
- "Summarize findings on [topic]"

**Report Generation**:
- "Create executive summary"
- "Generate competitive analysis report"
- "Export research to Word document"
- "Create literature review"

### 7.2 Conversation Flows

**Flow 1: New Research Project**
```
User: "Start a new research project on API management trends"

Bob: 
1. Creates research/api-management-trends/ folder
2. Initializes project files
3. Asks: "What sources should I start with?"

User: "Find all Gartner and Forrester reports on API management"

Bob:
1. Searches sources/Gartner/ and sources/Forrester/
2. Lists relevant documents
3. Asks: "Should I analyze these sources now?"

User: "Yes, create a trend analysis"

Bob:
1. Reads selected sources
2. Identifies key trends
3. Creates analysis document
4. Asks: "Would you like me to generate a report?"
```

**Flow 2: Document Processing**
```
User: "I have 5 PDFs from AWS re:Invent. Convert them to markdown"

Bob:
1. Asks for file location
2. Confirms target folder (sources/Hyperscalers/AWS/)
3. Asks about image handling
4. Executes batch conversion
5. Reports results and locations
```

## Phase 8: Advanced Features

### 8.1 Citation Management

**Citation Tracking**:
- Maintain source references
- Format citations consistently
- Link findings to sources
- Generate bibliography

**Citation Format**:
```markdown
[1] Gartner. "Magic Quadrant for API Management." 2024.
    Source: sources/Gartner/magic-quadrant-2024.md

[2] Forrester. "API Management Platforms Wave." 2024.
    Source: sources/Forrester/api-wave-2024.md
```

### 8.2 Version Control

**Research Iterations**:
- Track changes to analysis
- Maintain version history
- Compare iterations
- Rollback if needed

**Version Naming**:
```
research/api-trends/
├── report-v1.md
├── report-v2.md
├── report-final.md
└── archive/
    └── report-draft.md
```

### 8.3 Batch Operations

**Bulk Processing**:
- Convert multiple documents at once
- Scrape multiple URLs
- Generate multiple reports
- Update multiple projects

**Example Batch Script**:
```bash
# Convert all PDFs in a folder
for pdf in sources/raw/*.pdf; do
  category=$(determine_category "$pdf")
  docling "$pdf" --output "sources/$category/$(basename "$pdf" .pdf).md" --no-images
done
```

## Phase 9: Quality Assurance

### 9.1 Validation Checks

**Document Conversion**:
- Verify output file exists
- Check markdown formatting
- Validate content extraction
- Confirm image handling

**Research Analysis**:
- Ensure all sources cited
- Verify findings supported by evidence
- Check for logical consistency
- Validate completeness

**Report Generation**:
- Verify Word document created
- Check formatting applied
- Validate structure
- Ensure all sections present

### 9.2 Error Handling

**Common Issues**:
- File not found
- Conversion failed
- Invalid URL
- Missing dependencies
- Permission errors

**Error Responses**:
- Clear error messages
- Suggested solutions
- Alternative approaches
- Recovery steps

## Phase 10: Documentation

### 10.1 README.md Structure

```markdown
# Research Assistant Skill

Streamline your research workflow with automated document conversion, web scraping, analysis, and report generation.

## Prerequisites
[Installation instructions for docling, crawl4ai, pandoc]

## Quick Start
[Basic usage examples]

## Workflows
[Common research workflows]

## Examples
[Detailed examples with screenshots]

## Troubleshooting
[Common issues and solutions]

## Advanced Usage
[Power user features]
```

### 10.2 Example Documentation

**Example Files**:
- Document conversion examples
- Web scraping examples
- Research analysis examples
- Report generation examples
- Complete workflow examples

**Each Example Includes**:
- User request
- Bob's actions
- Commands executed
- Expected output
- Verification steps

## Implementation Checklist

### Core Components
- [ ] Create skill directory structure
- [ ] Write SKILL.md with complete instructions
- [ ] Create README.md with user documentation
- [ ] Add CLI tool integration guides
- [ ] Create workflow documentation

### Templates
- [ ] Literature review template
- [ ] Competitive analysis template
- [ ] Executive summary template
- [ ] Research report template
- [ ] Technical deep dive template

### Examples
- [ ] Document conversion examples
- [ ] Web scraping examples
- [ ] Research analysis examples
- [ ] Report generation examples
- [ ] End-to-end workflow examples

### Guides
- [ ] Docling usage guide
- [ ] Crawl4ai usage guide
- [ ] Pandoc usage guide
- [ ] Source organization guide
- [ ] Best practices guide

### Testing
- [ ] Test document conversion
- [ ] Test web scraping
- [ ] Test research workflows
- [ ] Test report generation
- [ ] Test error handling

### Documentation
- [ ] Installation instructions
- [ ] Quick start guide
- [ ] Detailed usage examples
- [ ] Troubleshooting guide
- [ ] FAQ section

## Success Metrics

The skill is ready for use when:
1. ✅ All core workflows are documented
2. ✅ CLI tool integration is clear and tested
3. ✅ Templates are comprehensive and usable
4. ✅ Examples cover common use cases
5. ✅ Error handling is robust
6. ✅ Documentation is complete and clear
7. ✅ User can complete end-to-end workflow without assistance

## Phase 11: Future Enhancement - Multimedia Transcription

### 11.1 Video/Audio Processing Pipeline

**Tools Integration**:
- **yt-dlp**: Download videos/audio from various platforms
- **ffmpeg**: Audio processing and format conversion
- **whisper.cpp**: Local speech-to-text transcription

**Workflow Architecture**:
```
Video/Audio URL → yt-dlp → Audio File → ffmpeg → Processed Audio → whisper.cpp → Transcript Markdown
```

### 11.2 Transcription Workflow

**Step-by-Step Process**:

1. **Download Content**
```bash
# Download video and extract audio
yt-dlp -x --audio-format mp3 \
  "https://youtube.com/watch?v=..." \
  -o "temp/%(title)s.%(ext)s"
```

2. **Process Audio**
```bash
# Normalize and prepare for transcription
ffmpeg -i temp/video.mp3 \
  -ar 16000 \
  -ac 1 \
  -c:a pcm_s16le \
  temp/processed.wav
```

3. **Transcribe**
```bash
# Run whisper.cpp transcription
whisper-cpp \
  -m models/ggml-base.en.bin \
  -f temp/processed.wav \
  -otxt \
  -of sources/Conferences/transcript
```

4. **Format and Organize**
- Add metadata header
- Format timestamps
- Extract key points
- Organize in sources folder
- Clean up temporary files

### 11.3 Transcript Template

```markdown
# [Video/Audio Title]

**Source**: [URL]
**Platform**: [YouTube/Podcast/etc]
**Date Published**: [Date]
**Duration**: [HH:MM:SS]
**Speaker(s)**: [Names]
**Transcribed**: [Date]
**Category**: [Conference/Podcast/Tutorial/etc]

---

## Summary
[Brief overview of content]

## Transcript

[00:00:00] Opening remarks and introduction...

[00:05:30] Discussion of main topic begins...

[00:15:45] Key point about technology trends...

---

## Key Takeaways
- [Important point 1]
- [Important point 2]
- [Important point 3]

## Topics Covered
- [Topic 1]
- [Topic 2]
- [Topic 3]

## References Mentioned
- [Resource 1]
- [Resource 2]

## Action Items
- [Follow-up item 1]
- [Follow-up item 2]
```

### 11.4 Use Cases

**Conference Talks**:
```
User: "Transcribe the AWS re:Invent keynote"
Bob: Downloads video, transcribes, organizes in sources/Hyperscalers/AWS/
```

**Podcast Episodes**:
```
User: "Get transcript of the latest API podcast episode"
Bob: Downloads audio, transcribes, saves to sources/Podcasts/
```

**Tutorial Videos**:
```
User: "Transcribe the Kong Gateway tutorial series"
Bob: Batch downloads and transcribes, organizes in sources/Competitors/Kong/
```

### 11.5 Advanced Features

**Batch Processing**:
```bash
# Process multiple videos from a playlist
yt-dlp --flat-playlist --get-id "playlist_url" | while read id; do
  process_video "https://youtube.com/watch?v=$id"
done
```

**Speaker Diarization** (Future):
- Identify different speakers
- Label speaker segments
- Track speaker contributions

**Timestamp Linking**:
- Link transcript sections to video timestamps
- Enable quick navigation to specific moments
- Reference specific quotes with timestamps

**Quality Control**:
- Confidence scores for transcription
- Flag uncertain sections for review
- Suggest manual verification points

### 11.6 Installation Guide (Future)

```bash
# yt-dlp
pip install yt-dlp

# ffmpeg
brew install ffmpeg  # macOS
apt-get install ffmpeg  # Linux
choco install ffmpeg  # Windows

# whisper.cpp
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
make

# Download models (choose based on accuracy/speed needs)
bash ./models/download-ggml-model.sh base.en    # Fast, good accuracy
bash ./models/download-ggml-model.sh medium.en  # Better accuracy, slower
bash ./models/download-ggml-model.sh large-v3   # Best accuracy, slowest
```

### 11.7 Configuration Options

**Model Selection**:
- `tiny.en`: Fastest, lowest accuracy (~1GB RAM)
- `base.en`: Good balance (~1GB RAM)
- `small.en`: Better accuracy (~2GB RAM)
- `medium.en`: High accuracy (~5GB RAM)
- `large-v3`: Best accuracy (~10GB RAM)

**Processing Options**:
- Language selection (start with English)
- Audio quality settings
- Timestamp granularity
- Output format preferences

### 11.8 Error Handling

**Common Issues**:
- Video unavailable or private
- Audio extraction failed
- Transcription timeout
- Insufficient disk space
- Model not found

**Solutions**:
- Validate URL before processing
- Check audio format compatibility
- Implement progress tracking
- Monitor disk space
- Provide model download instructions

### 11.9 Privacy & Legal Considerations

**Best Practices**:
- Respect copyright and fair use
- Only transcribe publicly available content
- Attribute sources properly
- Consider platform terms of service
- Local processing for privacy

**Compliance**:
- Document source and date
- Include original URL
- Note transcription method
- Respect content licenses

## Next Steps

After reviewing this plan:
1. Confirm the approach meets your needs
2. Identify any missing requirements
3. Prioritize features for initial release
4. Decide if multimedia transcription should be in Phase 1 or Phase 2
5. Switch to Code mode for implementation
## Phase 12: Future Enhancement - Presentation Generation

### 12.1 Marp Integration (Recommended)

**Why Marp**:
- Native VS Code extension integration
- Markdown-based (seamless with research workflow)
- Export to multiple formats (PPTX, PDF, HTML)
- Live preview in VS Code
- Theme customization
- Version control friendly

**Installation**:
```bash
# Install Marp CLI
npm install -g @marp-team/marp-cli

# Install VS Code extension
code --install-extension marp-team.marp-vscode
```

### 12.2 Presentation Generation Workflow

**Step-by-Step Process**:

1. **Analyze Research Content**
   - Read research report markdown
   - Identify key sections and findings
   - Extract data points and insights
   - Determine presentation structure

2. **Generate Presentation Outline**
   - Create slide structure
   - Allocate content to slides
   - Identify visual elements needed
   - Plan slide transitions

3. **Create Marp Markdown**
```markdown
---
marp: true
theme: default
paginate: true
backgroundColor: #fff
---

# Research Findings: API Management Trends

**Presenter**: [Name]
**Date**: [Date]

---

## Executive Summary

- Market growing at 15% CAGR
- Cloud-native solutions dominating
- Security becoming key differentiator

---

## Market Overview

![bg right:40% 80%](images/market-chart.png)

- Market size: $4.5 billion
- Growth rate: 15% CAGR
- Key players: AWS, Azure, Kong

---

## Competitive Analysis

| Vendor | Market Share | Strengths | Weaknesses |
|--------|-------------|-----------|------------|
| AWS    | 35%         | Scale, Integration | Complexity |
| Kong   | 20%         | Features, OSS | Enterprise support |
| Azure  | 25%         | Cloud integration | Learning curve |

---

## Key Trends

1. **API-First Development**
   - Microservices architecture
   - Event-driven systems

2. **Security Focus**
   - Zero-trust architecture
   - API threat protection

3. **Developer Experience**
   - Self-service portals
   - Better documentation

---

## Recommendations

### Short-term (0-6 months)
- Evaluate Kong Gateway
- Pilot API security tools

### Medium-term (6-12 months)
- Implement API governance
- Scale to production

### Long-term (12+ months)
- Full platform migration
- Advanced analytics

---

## Questions?

**Contact**: research@company.com
**Next Steps**: Schedule follow-up meeting
```

4. **Export to Formats**
```bash
# Export to PowerPoint
marp slides.md -o output/presentation.pptx

# Export to PDF
marp slides.md -o output/presentation.pdf

# Export to HTML
marp slides.md -o output/presentation.html
```

### 12.3 Presentation Templates

**Template Library**:

**Executive Briefing Template**:
```markdown
---
marp: true
theme: corporate
paginate: true
---

# [Topic]: Executive Briefing

**Date**: [Date]
**Prepared by**: [Name]

---

## Situation

[Current state and context]

---

## Analysis

[Key findings and insights]

---

## Recommendations

[Actionable next steps]

---

## Financial Impact

[Cost/benefit analysis]
```

**Technical Deep Dive Template**:
```markdown
---
marp: true
theme: technical
paginate: true
---

# [Topic]: Technical Analysis

---

## Architecture Overview

[System diagrams]

---

## Technical Details

[Implementation specifics]

---

## Performance Metrics

[Benchmarks and data]

---

## Implementation Plan

[Technical roadmap]
```

**Competitive Analysis Template**:
```markdown
---
marp: true
theme: business
paginate: true
---

# Competitive Landscape: [Market]

---

## Market Overview

[Market size, growth, trends]

---

## Competitor Comparison

[Feature matrix]

---

## SWOT Analysis

[Strengths, Weaknesses, Opportunities, Threats]

---

## Strategic Recommendations

[Positioning and next steps]
```

### 12.4 Smart Presentation Features

**Auto-Generation from Research**:
```
User: "Create an executive presentation from the API trends research"

Bob Actions:
1. Reads research/api-trends/report.md
2. Identifies key sections:
   - Executive Summary → Title slide + Summary slide
   - Market Analysis → Market Overview slides
   - Findings → Key Findings slides
   - Recommendations → Recommendations slides
3. Extracts data for charts/tables
4. Generates Marp markdown
5. Saves to output/presentations/api-trends-executive/
6. Exports to PPTX and PDF
7. Opens preview in VS Code
```

**Content Extraction Rules**:
- H1 headers → Section dividers
- H2 headers → Slide titles
- Bullet lists → Slide bullets (max 5 per slide)
- Tables → Comparison slides
- Images → Visual slides with captions
- Quotes → Emphasis slides

**Slide Density Management**:
- Max 5 bullets per slide
- Max 30 words per bullet
- One main idea per slide
- Use speaker notes for details

### 12.5 Theme Customization

**Corporate Theme Example**:
```css
/* theme.css */
@import 'default';

section {
  background-color: #ffffff;
  color: #333333;
  font-family: 'Arial', sans-serif;
}

h1 {
  color: #0066cc;
  border-bottom: 3px solid #0066cc;
}

h2 {
  color: #0066cc;
}

table {
  border-collapse: collapse;
}

th {
  background-color: #0066cc;
  color: white;
}
```

**Apply Custom Theme**:
```bash
marp slides.md --theme theme.css -o presentation.pptx
```

### 12.6 Advanced Features

**Speaker Notes**:
```markdown
---

## Market Overview

- Market size: $4.5B
- Growth: 15% CAGR

<!--
Speaker notes:
- Emphasize the rapid growth
- Mention key drivers: cloud adoption, microservices
- Reference Gartner report for credibility
-->
```

**Background Images**:
```markdown
---

![bg](images/background.jpg)

# Section Title

---

![bg right:40%](images/chart.png)

## Content with Side Image

- Point 1
- Point 2
```

**Multi-Column Layouts**:
```markdown
---

<div class="columns">
<div>

## Left Column

- Point 1
- Point 2

</div>
<div>

## Right Column

- Point A
- Point B

</div>
</div>
```

### 12.7 Workflow Integration

**Complete Presentation Workflow**:

```
1. Research Phase
   User: "Research API management trends"
   Bob: Gathers sources, analyzes, creates report.md

2. Presentation Request
   User: "Create executive presentation"
   Bob: Generates Marp markdown from report

3. Review & Edit
   User: Reviews in VS Code with live preview
   User: "Add a slide about security trends"
   Bob: Inserts new slide with security content

4. Export
   User: "Export to PowerPoint"
   Bob: Generates PPTX file

5. Finalize
   User: "Also create PDF version"
   Bob: Generates PDF file
```

### 12.8 Alternative Tools

**Presenterm** (Terminal Presentations):
```bash
# Install
cargo install presenterm

# Create presentation
cat > slides.md << 'EOF'
# Slide 1
Content here

---

# Slide 2
More content
EOF

# Present
presenterm slides.md
```

**OpenGamma.app** (Web-based):
- Upload markdown file
- Visual editor for refinements
- Cloud storage and sharing
- Collaboration features
- Export to multiple formats

**Presenton.ai** (AI-powered):
- AI-generated slide content
- Smart layout suggestions
- Auto-formatting
- Design recommendations
- Brand consistency

### 12.9 Quality Assurance

**Presentation Checklist**:
- [ ] Clear title and date on first slide
- [ ] Consistent theme throughout
- [ ] Max 5 bullets per slide
- [ ] Readable font sizes (min 24pt)
- [ ] High-quality images
- [ ] Proper citations for data
- [ ] Speaker notes included
- [ ] Logical flow between slides
- [ ] Strong conclusion/call-to-action
- [ ] Contact information on last slide

**Export Validation**:
- [ ] PPTX opens correctly in PowerPoint
- [ ] PDF renders properly
- [ ] Images display correctly
- [ ] Tables are formatted
- [ ] Links are functional
- [ ] File size is reasonable

### 12.10 Example Use Cases

**Use Case 1: Executive Briefing**
```
User: "Create a 10-slide executive briefing on API trends"

Bob:
1. Analyzes research report
2. Extracts top 10 insights
3. Creates executive-briefing template
4. Generates 10 slides:
   - Title
   - Executive Summary
   - Market Overview
   - Key Trends (3 slides)
   - Competitive Landscape
   - Recommendations
   - Financial Impact
   - Next Steps
   - Q&A
5. Exports to PPTX
```

**Use Case 2: Conference Talk**
```
User: "Create a 30-minute conference presentation on our research"

Bob:
1. Calculates ~20-25 slides for 30 minutes
2. Creates technical-deep-dive template
3. Structures content:
   - Introduction (2 slides)
   - Background (3 slides)
   - Methodology (2 slides)
   - Findings (10 slides)
   - Discussion (5 slides)
   - Conclusion (2 slides)
   - Q&A (1 slide)
4. Adds speaker notes with timing
5. Exports to PDF and PPTX
```

**Use Case 3: Training Materials**
```
User: "Create training slides from the API Gateway tutorial"

Bob:
1. Reads tutorial content
2. Creates training-materials template
3. Breaks into learning modules
4. Adds exercises and examples
5. Includes hands-on labs
6. Exports to HTML for interactive use
```

### 12.11 Best Practices

**Content Guidelines**:
- One main idea per slide
- Use visuals over text when possible
- Keep bullets concise (max 10 words)
- Use consistent terminology
- Include data sources
- Add speaker notes for context

**Design Guidelines**:
- Consistent color scheme
- Readable fonts (min 24pt)
- High-contrast text/background
- Professional images only
- Proper spacing and alignment
- Minimal animations

**Presentation Structure**:
- Strong opening (hook audience)
- Clear agenda/outline
- Logical progression
- Regular summaries
- Strong conclusion
- Clear call-to-action
