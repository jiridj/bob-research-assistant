# Research Assistant Skill Optimization Plan

**Date:** 2026-06-20  
**Current Size:** 1024 lines  
**Target Reduction:** 30-40% (~300-400 lines)  
**Goal:** Maximize utility and outcome while minimizing token consumption

---

## Executive Summary

The Research Assistant SKILL.md contains significant redundancy and verbosity that increases token consumption without proportional value. This plan identifies 8 major optimization opportunities that can reduce the file by ~35% while improving clarity and maintaining all essential functionality.

**Key Findings:**
- **Repetitive Examples:** 150+ lines of redundant workflow examples
- **Verbose Explanations:** 100+ lines of over-explained concepts
- **Duplicate Validation:** 80+ lines of repeated validation patterns
- **Redundant Documentation:** 70+ lines pointing to non-existent guides

**Estimated Token Savings:** ~350 lines (34% reduction)

---

## Optimization Opportunities

### 1. Consolidate Repetitive Examples (Lines 552-642)
**Current:** 90 lines  
**Optimized:** 30 lines  
**Savings:** 60 lines (67% reduction)

**Issue:**
- Three separate document conversion examples showing nearly identical workflows
- Two web scraping examples with redundant steps
- Each example repeats the same validation and error handling patterns

**Solution:**
```markdown
### Document Conversion Examples

**Single File (No Images):**
```bash
cp source.pdf originals/pdf/
docling originals/pdf/source.pdf --output sources/pdf/ --image-export-mode placeholder
```

**Single File (With Images):**
```bash
cp source.pdf originals/pdf/
docling originals/pdf/source.pdf --output originals/images/ --image-export-mode referenced
mv originals/images/source.md sources/pdf/
sed -i '' 's|./source/|../../originals/images/source/|g' sources/pdf/source.md
```

**Batch Processing:**
```bash
cp *.pdf originals/pdf/
./scripts/batch-convert-pdfs.sh
```

### Web Scraping Examples

**Single Page:**
```bash
./scripts/scrape-with-version.sh 'URL' 'COMPANY' 'PAGE'
# Auto-creates: sources/web/COMPANY/PAGE-YYYY-MM-DD.md
```

**Batch:**
```bash
./scripts/batch-scrape-urls.sh urls.txt [DELAY]
```
```

**Impact:** Removes redundant explanations while keeping essential command patterns.

---

### 2. Eliminate Verbose Workflow Descriptions (Lines 161-235)
**Current:** 74 lines  
**Optimized:** 25 lines  
**Savings:** 49 lines (66% reduction)

**Issue:**
- Overly detailed step-by-step workflows with redundant explanations
- Multiple examples showing the same concept
- Verbose commentary that doesn't add value

**Solution:**
Replace verbose workflows with concise command patterns and critical notes only:

```markdown
### Document Conversion (Docling)

**Key Principles:**
- Images excluded by default (`--image-export-mode placeholder`)
- For images: use `--image-export-mode referenced`
- Always convert from `originals/` copy, output to `sources/`

**Single File:**
```bash
cp /path/to/file.pdf originals/pdf/
docling originals/pdf/file.pdf --output sources/pdf/ --image-export-mode placeholder
```

**With Images:**
```bash
docling originals/pdf/file.pdf --output originals/images/ --image-export-mode referenced
mv originals/images/file.md sources/pdf/
sed -i '' 's|./file/|../../originals/images/file/|g' sources/pdf/file.md
```

**Batch:** Use `./scripts/batch-convert-pdfs.sh` for multiple files
```

---

### 3. Consolidate Web Scraping Instructions (Lines 236-352)
**Current:** 116 lines  
**Optimized:** 45 lines  
**Savings:** 71 lines (61% reduction)

**Issue:**
- Excessive explanation of parameter determination
- Redundant examples of URL parsing
- Verbose workflow steps that repeat the same pattern

**Solution:**
```markdown
### Web Scraping (Crawl4ai)

**Command:** `./scripts/scrape-with-version.sh URL COMPANY PAGE`

**Parameter Rules:**
- **COMPANY:** Domain-based (wikipedia.org → Wikipedia, konghq.com → Kong)
- **PAGE:** URL path slug (e.g., /api-gateway → api-gateway)

**Examples:**
- `./scripts/scrape-with-version.sh 'https://en.wikipedia.org/wiki/AI' 'Wikipedia' 'ai'`
- `./scripts/scrape-with-version.sh 'https://konghq.com/pricing' 'Kong' 'pricing'`

**Batch:** `./scripts/batch-scrape-urls.sh urls.txt [DELAY]`

**Output:** `sources/web/COMPANY/PAGE-YYYY-MM-DD.md` + JSON metadata
```

---

### 4. Remove Redundant Validation Sections (Lines 755-994)
**Current:** 239 lines  
**Optimized:** 80 lines  
**Savings:** 159 lines (67% reduction)

**Issue:**
- Quality Assurance section (239 lines) repeats validation patterns already covered
- Extensive checklists that are rarely used
- Verbose error handling examples showing basic bash patterns
- Duplicate validation logic across multiple subsections

**Solution:**
Consolidate into a single, focused validation section:

```markdown
## Quality Assurance

**Pre-Operation:**
- Verify dependencies: `command -v docling crwl pandoc`
- Check file/URL accessibility
- Confirm sufficient disk space

**Post-Operation:**
- Verify output files exist and have content
- Check formatting (headings, tables, links)
- Validate metadata completeness

**Common Issues:**
- **File not found:** Check path and permissions
- **Conversion failed:** Verify file isn't corrupted/password-protected
- **URL inaccessible:** Check network and URL validity
- **Missing dependencies:** Install via pip/brew

**Validation Commands:**
```bash
# Check output exists
[ -f output.md ] && [ -s output.md ] && echo "✓ Success"

# Count content
wc -l output.md
grep -c "^#" output.md  # Headings
```
```

---

### 5. Streamline Conversation Flows (Lines 498-549)
**Current:** 51 lines  
**Optimized:** 15 lines  
**Savings:** 36 lines (71% reduction)

**Issue:**
- Three verbose conversation examples with redundant patterns
- Excessive back-and-forth dialogue that doesn't add value
- Same workflow pattern repeated three times

**Solution:**
```markdown
### User Interaction Patterns

**Common Commands:**
- "Convert [file] to markdown" → Copy to originals/, run docling
- "Scrape [URL]" → Auto-extract COMPANY/PAGE, run scrape script
- "Start research on [topic]" → Create project structure, ask for sources
- "Compare [A] and [B]" → Search sources, create comparison matrix
- "Generate [report type]" → Use template, populate with findings
```

---

### 6. Remove Non-Existent Documentation References (Lines 995-1024)
**Current:** 29 lines  
**Optimized:** 8 lines  
**Savings:** 21 lines (72% reduction)

**Issue:**
- References to 10+ guides that don't exist
- Links to 6+ example directories that aren't present
- Creates confusion and wastes tokens

**Solution:**
```markdown
## Documentation

**Templates:** See `templates/` directory
- company-pov.md, company-deep-dive.md, competitor-analysis.md
- market-analysis.md, technical-deep-dive.md, why-how-what.md
- _common-elements.md (shared components)

**Scripts:** See `scripts/` directory for automation tools
```

---

### 7. Consolidate Project Initialization (Lines 57-158)
**Current:** 101 lines  
**Optimized:** 40 lines  
**Savings:** 61 lines (60% reduction)

**Issue:**
- Verbose explanation of folder structure with ASCII art
- Redundant description of source organization
- Lengthy goals.md template that could be referenced

**Solution:**
```markdown
### Project Initialization

**Structure:**
```
sources/          # Shared across all projects
├── pdf/          # Converted documents
├── web/          # Scraped content
└── images/       # Extracted images

originals/        # Original files
└── pdf/          # Source PDFs

research/[topic]/ # Project-specific
├── goals.md      # Objectives and questions
├── notes/        # Research notes
├── analysis/     # Analysis documents
└── reports/      # Final deliverables
```

**Setup:**
```bash
mkdir -p research/[topic]/{notes,analysis,reports}
```

**Create goals.md** with: objectives, key questions, success criteria, scope, timeline
```

---

### 8. Simplify Advanced Features (Lines 663-754)
**Current:** 91 lines  
**Optimized:** 30 lines  
**Savings:** 61 lines (67% reduction)

**Issue:**
- Citation Management, Version Control, and Batch Operations sections are overly verbose
- Redundant examples showing basic git/bash commands
- Links to non-existent guides

**Solution:**
```markdown
## Advanced Features

**Citation Management:**
Add YAML frontmatter to sources:
```yaml
---
citation:
  id: source-2024
  author: "Author Name"
  title: "Document Title"
  date: 2024-01-01
---
```

**Version Control:**
```bash
git init && git add . && git commit -m "Initial commit"
```

**Batch Operations:**
- Documents: `./scripts/batch-convert-pdfs.sh`
- Web: `./scripts/batch-scrape-urls.sh urls.txt [DELAY]`
- Reports: `pandoc *.md -o report.docx`
```

---

## Implementation Strategy

### Phase 1: High-Impact Reductions (Priority 1)
1. Remove redundant validation section (#4) - **159 lines**
2. Consolidate examples (#1) - **60 lines**
3. Streamline web scraping (#3) - **71 lines**

**Total Phase 1 Savings:** 290 lines (28%)

### Phase 2: Medium-Impact Optimizations (Priority 2)
4. Simplify project init (#7) - **61 lines**
5. Consolidate advanced features (#8) - **61 lines**
6. Eliminate verbose workflows (#2) - **49 lines**

**Total Phase 2 Savings:** 171 lines (17%)

### Phase 3: Final Cleanup (Priority 3)
7. Streamline conversation flows (#5) - **36 lines**
8. Remove non-existent docs (#6) - **21 lines**

**Total Phase 3 Savings:** 57 lines (6%)

**Grand Total:** 518 lines reduced (51% reduction)

---

## Preserved Elements

**Keep Unchanged:**
- Persona section (lines 8-21) - Critical for behavior
- Core Capabilities (lines 34-44) - Essential overview
- Required Commands (lines 22-33) - Dependency list
- Research Methodologies (lines 395-470) - Unique value
- Best Practices (lines 643-655) - Concise and useful

---

## Risk Mitigation

**Potential Concerns:**
1. **Loss of detail:** Mitigated by keeping all essential commands and critical notes
2. **User confusion:** Improved by clearer, more concise explanations
3. **Missing examples:** Retained most important patterns, removed redundancy

**Validation:**
- All CLI commands preserved
- All critical workflows documented
- All unique functionality retained
- Improved readability and scannability

---

## Expected Outcomes

**Token Efficiency:**
- **Before:** ~1024 lines (~15,000 tokens estimated)
- **After:** ~500 lines (~7,500 tokens estimated)
- **Savings:** ~50% token reduction

**User Experience:**
- Faster to scan and find information
- Clearer command patterns
- Less cognitive load
- Maintained all essential functionality

**Maintainability:**
- Easier to update
- Less duplication to manage
- Clearer structure

---

## Next Steps

1. **Review this plan** - Approve optimization strategy
2. **Implement Phase 1** - High-impact reductions first
3. **Test functionality** - Verify all commands still work
4. **Implement Phase 2 & 3** - Complete optimization
5. **Update documentation** - Reflect new structure
6. **Commit changes** - Version control the optimization

---

## Approval Required

Please review this optimization plan and approve to proceed with implementation.

**Questions to Consider:**
1. Are there any sections you want to preserve as-is?
2. Should we implement all phases or start with Phase 1 only?
3. Any specific concerns about the proposed changes?