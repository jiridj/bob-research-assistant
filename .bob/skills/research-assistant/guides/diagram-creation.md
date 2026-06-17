# Diagram Creation with Mermaid

This guide explains how to create and use diagrams in your research documents using Mermaid.js.

## Overview

Mermaid is a JavaScript-based diagramming tool that renders text-based definitions into diagrams. It's perfect for research documents because:

- **Version Control Friendly**: Diagrams are text, not binary files
- **Easy to Edit**: Simple syntax for creating complex diagrams
- **Multiple Types**: Flowcharts, sequence diagrams, Gantt charts, and more
- **Markdown Compatible**: Works directly in markdown files

## Prerequisites

### Required Tools

1. **mermaid-cli** - For rendering diagrams to images
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

2. **VS Code Extension** (Recommended)
   - [Mermaid Preview](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)
   - Provides live preview of diagrams in VS Code

### Verification

```bash
# Check mermaid-cli installation
mmdc --version

# Should output version number
```

## Diagram Types

### 1. Flowcharts

Perfect for process flows, decision trees, and workflows.

```mermaid
flowchart TD
    A[Start Research] --> B{Define Scope}
    B -->|Clear| C[Gather Sources]
    B -->|Unclear| D[Refine Questions]
    D --> B
    C --> E[Analyze Data]
    E --> F[Generate Report]
    F --> G[End]
```

**Usage in Research:**
- Research methodology workflows
- Decision-making processes
- Data processing pipelines

### 2. Sequence Diagrams

Show interactions between components over time.

```mermaid
sequenceDiagram
    participant User
    participant Bob
    participant Docling
    participant Sources
    
    User->>Bob: Convert PDF to markdown
    Bob->>Docling: Execute conversion
    Docling->>Sources: Save markdown file
    Sources-->>Bob: Confirm saved
    Bob-->>User: Conversion complete
```

**Usage in Research:**
- System interactions
- API workflows
- Process sequences

### 3. Gantt Charts

Project timelines and schedules.

```mermaid
gantt
    title Research Project Timeline
    dateFormat YYYY-MM-DD
    section Planning
    Define Scope           :2024-01-01, 7d
    Identify Sources       :2024-01-08, 5d
    section Execution
    Gather Data           :2024-01-13, 14d
    Analyze Findings      :2024-01-27, 10d
    section Reporting
    Draft Report          :2024-02-06, 7d
    Review & Finalize     :2024-02-13, 5d
```

**Usage in Research:**
- Project planning
- Milestone tracking
- Resource allocation

### 4. Class Diagrams

Structure and relationships.

```mermaid
classDiagram
    class ResearchProject {
        +String title
        +Date startDate
        +List sources
        +analyze()
        +generateReport()
    }
    class Source {
        +String type
        +String path
        +Date added
        +convert()
    }
    class Report {
        +String format
        +String template
        +generate()
    }
    
    ResearchProject "1" --> "*" Source
    ResearchProject "1" --> "1" Report
```

**Usage in Research:**
- Data models
- System architecture
- Conceptual frameworks

### 5. Entity Relationship Diagrams

Data relationships and structures.

```mermaid
erDiagram
    RESEARCH-PROJECT ||--o{ SOURCE : contains
    RESEARCH-PROJECT ||--|| REPORT : generates
    SOURCE ||--o{ CITATION : has
    REPORT ||--o{ CITATION : includes
    
    RESEARCH-PROJECT {
        string title
        date created
        string status
    }
    SOURCE {
        string type
        string path
        date added
    }
    REPORT {
        string format
        string template
        date generated
    }
```

**Usage in Research:**
- Database design
- Data relationships
- Information architecture

### 6. Mind Maps

Brainstorming and concept mapping.

```mermaid
mindmap
  root((Research Topic))
    Literature Review
      Academic Papers
      Industry Reports
      Case Studies
    Methodology
      Qualitative
      Quantitative
      Mixed Methods
    Analysis
      Trends
      Patterns
      Gaps
    Findings
      Key Insights
      Recommendations
      Future Work
```

**Usage in Research:**
- Brainstorming sessions
- Concept organization
- Topic exploration

### 7. Timeline

Historical or sequential events.

```mermaid
timeline
    title Research Project Milestones
    2024-01 : Project Kickoff
           : Initial Planning
    2024-02 : Data Collection
           : Source Analysis
    2024-03 : Preliminary Findings
           : Draft Report
    2024-04 : Final Review
           : Publication
```

**Usage in Research:**
- Project history
- Event sequences
- Milestone tracking

## Creating Diagrams

### In Markdown Files

Simply include Mermaid code in fenced code blocks:

````markdown
```mermaid
flowchart LR
    A[Start] --> B[Process]
    B --> C[End]
```
````

### Rendering to Images

Use mermaid-cli to convert diagrams to images:

```bash
# Render single diagram
mmdc -i diagram.mmd -o diagram.png

# Render with specific theme
mmdc -i diagram.mmd -o diagram.png -t dark

# Render with custom size
mmdc -i diagram.mmd -o diagram.png -w 1920 -H 1080
```

### In Research Reports

#### When to Use Each Approach

**Use Mermaid Code (Option 1)** - Recommended for:
- ✅ Internal documentation and working documents
- ✅ GitHub/GitLab repositories (native Mermaid support)
- ✅ VS Code with Mermaid Preview extension
- ✅ Documents that change frequently
- ✅ Collaborative editing (easy to review changes)
- ✅ Version control (text-based, shows diffs)

**Use Rendered Images (Option 2)** - Required for:
- ✅ Final reports exported to Word/PDF via Pandoc
- ✅ Presentations (PPTX, PDF)
- ✅ Platforms without Mermaid support
- ✅ Print publications
- ✅ Email attachments
- ✅ Static documentation sites without Mermaid plugin

#### Option 1: Keep as Mermaid Code (Recommended for Working Documents)

```markdown
## Research Workflow

```mermaid
flowchart TD
    A[Define Scope] --> B[Gather Sources]
    B --> C[Analyze Data]
    C --> D[Generate Report]
```
```

**Advantages:**
- Live preview in VS Code with extension
- Easy to edit and update
- Version control friendly
- No separate image files to manage
- Automatic rendering on GitHub/GitLab

**When to use:**
- During research and analysis phase
- In markdown files viewed in VS Code or GitHub
- For collaborative documents
- When diagrams change frequently

#### Option 2: Render to Image (Required for Final Deliverables)

```bash
# Render diagram
mmdc -i workflow.mmd -o images/workflow.png

# Reference in markdown
![Research Workflow](images/workflow.png)
```

**Advantages:**
- Works in any document format (Word, PDF, PowerPoint)
- Consistent rendering across all platforms
- No plugin dependencies
- Professional appearance in final reports

**When to use:**
- Generating final reports with Pandoc
- Creating presentations
- Exporting to Word/PDF
- Sharing with non-technical stakeholders
- Publishing to platforms without Mermaid support

#### Recommended Workflow

```bash
# 1. During Research: Use Mermaid code in markdown
# Edit in VS Code with live preview
vim research/project/analysis.md

# 2. Before Final Report: Render to images
mmdc -i diagrams/workflow.mmd -o images/workflow.png
mmdc -i diagrams/architecture.mmd -o images/architecture.png

# 3. Generate Report: Pandoc uses the images
pandoc research/project/report.md -o output/report.docx
```

**Pro Tip:** Keep both! Store `.mmd` source files in `diagrams/` and rendered images in `images/`. This way you can:
- Edit diagrams easily (from `.mmd` files)
- Use in final reports (from `.png` files)
- Track changes in version control (`.mmd` files show diffs)

## Best Practices

### 1. Keep Diagrams Simple

❌ **Too Complex:**
```mermaid
flowchart TD
    A --> B & C & D & E & F
    B --> G & H & I
    C --> J & K & L
    D --> M & N & O
    E --> P & Q & R
    F --> S & T & U
```

✅ **Better:**
```mermaid
flowchart TD
    A[Main Process] --> B[Sub-Process 1]
    A --> C[Sub-Process 2]
    A --> D[Sub-Process 3]
```

### 2. Use Descriptive Labels

❌ **Unclear:**
```mermaid
flowchart LR
    A --> B --> C
```

✅ **Clear:**
```mermaid
flowchart LR
    A[Collect Data] --> B[Analyze Results] --> C[Generate Report]
```

### 3. Choose the Right Diagram Type

- **Process/Workflow**: Flowchart
- **Interactions**: Sequence Diagram
- **Timeline**: Gantt Chart or Timeline
- **Structure**: Class Diagram or ER Diagram
- **Concepts**: Mind Map

### 4. Use Consistent Styling

```mermaid
flowchart TD
    A[Start]:::startEnd
    B[Process]:::process
    C[Decision]:::decision
    D[End]:::startEnd
    
    A --> B --> C
    C -->|Yes| D
    C -->|No| B
    
    classDef startEnd fill:#90EE90
    classDef process fill:#87CEEB
    classDef decision fill:#FFB6C1
```

### 5. Version Control Diagrams

Store diagram source files separately:

```
research/project/
├── diagrams/
│   ├── workflow.mmd
│   ├── architecture.mmd
│   └── timeline.mmd
├── images/
│   ├── workflow.png
│   ├── architecture.png
│   └── timeline.png
└── report.md
```

## Integration with Research Workflow

### 1. Planning Phase

Use mind maps and flowcharts:

```mermaid
mindmap
  root((API Gateway Research))
    Vendors
      Kong
      Apigee
      MuleSoft
    Features
      Rate Limiting
      Authentication
      Analytics
    Use Cases
      Microservices
      API Management
      Security
```

### 2. Execution Phase

Use sequence diagrams and flowcharts:

```mermaid
flowchart TD
    A[Identify Sources] --> B[Convert Documents]
    B --> C[Extract Key Points]
    C --> D[Organize by Theme]
    D --> E[Analyze Patterns]
    E --> F[Document Findings]
```

### 3. Reporting Phase

Use Gantt charts and timelines:

```mermaid
gantt
    title Report Generation Timeline
    dateFormat YYYY-MM-DD
    section Writing
    Executive Summary    :2024-03-01, 2d
    Methodology         :2024-03-03, 3d
    Findings           :2024-03-06, 5d
    section Review
    Internal Review     :2024-03-11, 3d
    Revisions          :2024-03-14, 2d
    Final Approval     :2024-03-16, 1d
```

## Common Use Cases

### Competitive Analysis

```mermaid
flowchart TD
    A[Identify Competitors] --> B[Gather Data]
    B --> C{Data Type}
    C -->|Features| D[Feature Matrix]
    C -->|Pricing| E[Pricing Comparison]
    C -->|Performance| F[Benchmark Results]
    D & E & F --> G[Competitive Analysis Report]
```

### Research Methodology

```mermaid
flowchart LR
    A[Research Question] --> B[Literature Review]
    B --> C[Data Collection]
    C --> D[Analysis]
    D --> E{Findings Valid?}
    E -->|Yes| F[Report]
    E -->|No| C
```

### System Architecture

```mermaid
graph TB
    subgraph "Research System"
        A[Bob AI] --> B[Research Assistant Skill]
        B --> C[Document Converter]
        B --> D[Web Scraper]
        B --> E[Report Generator]
    end
    
    subgraph "External Tools"
        C --> F[Docling]
        D --> G[Crawl4AI]
        E --> H[Pandoc]
    end
```

## Troubleshooting

### Diagram Not Rendering

**Issue**: Diagram doesn't appear in preview

**Solutions**:
1. Check Mermaid syntax
2. Verify VS Code extension is installed
3. Ensure code block uses `mermaid` language identifier

### Syntax Errors

**Issue**: Diagram shows error message

**Solutions**:
1. Validate syntax at [Mermaid Live Editor](https://mermaid.live/)
2. Check for missing arrows or brackets
3. Verify node IDs are unique

### Export Issues

**Issue**: mmdc command fails

**Solutions**:
```bash
# Reinstall mermaid-cli
npm install -g @mermaid-js/mermaid-cli

# Check for puppeteer issues
npm install -g puppeteer

# Use specific output format
mmdc -i input.mmd -o output.svg  # Try SVG instead of PNG
```

## Resources

### Official Documentation
- [Mermaid Documentation](https://mermaid.js.org/)
- [Mermaid Live Editor](https://mermaid.live/)
- [Mermaid CLI](https://github.com/mermaid-js/mermaid-cli)

### VS Code Extensions
- [Mermaid Preview](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)
- [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)

### Examples and Templates
- See `examples/` directory for diagram templates
- Check research reports for real-world usage

## Quick Reference

### Flowchart Syntax
```
flowchart TD    # Top to Down
flowchart LR    # Left to Right
A[Rectangle]    # Node with text
A --> B         # Arrow
A -.-> B        # Dotted arrow
A ==> B         # Thick arrow
```

### Sequence Diagram Syntax
```
participant A
participant B
A->>B: Message
B-->>A: Response
```

### Gantt Chart Syntax
```
gantt
    title Project
    dateFormat YYYY-MM-DD
    section Phase
    Task :2024-01-01, 7d
```

---

**Pro Tip**: Use the Mermaid Live Editor to prototype diagrams, then copy the code into your research documents!

**Last Updated**: 2026-06-17