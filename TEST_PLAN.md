# Research Assistant Skill - Test Plan

Comprehensive test plan to validate all functionalities of the Research Assistant skill.

## 📋 Table of Contents

1. [Pre-Test Setup](#pre-test-setup)
2. [Installation Testing](#installation-testing)
3. [Core Functionality Tests](#core-functionality-tests)
4. [Utility Scripts Testing](#utility-scripts-testing)
5. [Documentation Testing](#documentation-testing)
6. [Integration Testing](#integration-testing)
7. [Edge Cases and Error Handling](#edge-cases-and-error-handling)
8. [Performance Testing](#performance-testing)
9. [Test Results Template](#test-results-template)

---

## Pre-Test Setup

### Environment Preparation

```bash
# 1. Create a clean test directory
mkdir ~/bob-skill-test
cd ~/bob-skill-test

# 2. Clone or copy the skill
git clone <your-repo-url> research-assistant-test
cd research-assistant-test

# 3. Verify prerequisites
which python3  # Should show Python 3 path
which node     # Should show Node.js path (optional for Mermaid)
which git      # Should show Git path
```

### Test Data Preparation

```bash
# Create test data directory
mkdir -p test-data/{pdfs,urls,markdown}

# Download sample PDFs (or use your own)
# Example: Research papers, documentation, etc.

# Create sample URLs file
cat > test-data/urls/sample-urls.txt << 'EOF'
https://en.wikipedia.org/wiki/Artificial_intelligence
https://en.wikipedia.org/wiki/Machine_learning
https://en.wikipedia.org/wiki/Natural_language_processing
EOF

# Create sample markdown files
cat > test-data/markdown/sample1.md << 'EOF'
# Sample Research Document

## Introduction
This is a test document for validation.

## References
- Smith, J. (2023). "AI Research"
- Jones, M. (2024). "ML Applications"
EOF
```

---

## Installation Testing

### Test 1.1: Fresh Installation

**Objective**: Verify clean installation on a system without the skill.

**Steps**:
```bash
# 1. Run installation script
./install.sh

# 2. Verify installation
ls -la ~/.bob/skills/research-assistant/

# 3. Check dependencies
python3 -c "import docling; print('docling OK')"
python3 -c "import crawl4ai; print('crawl4ai OK')"
which pandoc && echo "pandoc OK"
```

**Expected Results**:
- ✅ Skill directory created at `~/.bob/skills/research-assistant/`
- ✅ All Python dependencies installed
- ✅ Scripts directory copied with execute permissions
- ✅ No error messages during installation

**Pass/Fail**: [ ]

---

### Test 1.2: Reinstallation

**Objective**: Verify skill can be reinstalled/updated.

**Steps**:
```bash
# 1. Run installation again
./install.sh

# 2. Verify no errors
echo $?  # Should be 0
```

**Expected Results**:
- ✅ Installation completes without errors
- ✅ Existing files are updated
- ✅ No data loss

**Pass/Fail**: [ ]

---

### Test 1.3: Dependency Verification

**Objective**: Verify all dependencies are correctly installed.

**Steps**:
```bash
# Run dependency check
python3 << 'EOF'
import sys
dependencies = ['docling', 'crawl4ai']
missing = []
for dep in dependencies:
    try:
        __import__(dep)
        print(f"✓ {dep}")
    except ImportError:
        print(f"✗ {dep}")
        missing.append(dep)
if missing:
    print(f"\nMissing: {', '.join(missing)}")
    sys.exit(1)
else:
    print("\nAll dependencies installed!")
EOF

# Also check pandoc
which pandoc > /dev/null && echo "✓ pandoc" || echo "✗ pandoc"
```

**Expected Results**:
- ✅ All dependencies show checkmarks
- ✅ No missing dependencies

**Pass/Fail**: [ ]

---

## Core Functionality Tests

### Test 2.1: Bob Skill Recognition

**Objective**: Verify Bob recognizes the skill.

**Steps**:
1. Open Bob
2. Type: "What skills do you have?"
3. Look for "Research Assistant" in the response

**Expected Results**:
- ✅ Research Assistant skill is listed
- ✅ Skill description is accurate

**Pass/Fail**: [ ]

---

### Test 2.2: PDF Conversion

**Objective**: Test PDF to markdown conversion.

**Steps**:
```bash
# In Bob, say:
"Convert the PDF at test-data/pdfs/sample.pdf to markdown"

# Or use script directly:
./scripts/batch-convert-pdfs.sh test-data/pdfs/
```

**Expected Results**:
- ✅ PDF is converted to markdown
- ✅ Text is extracted correctly
- ✅ Formatting is preserved where possible
- ✅ Output file created in correct location

**Pass/Fail**: [ ]

---

### Test 2.3: Web Scraping

**Objective**: Test web content extraction.

**Steps**:
```bash
# In Bob, say:
"Scrape the content from https://en.wikipedia.org/wiki/Artificial_intelligence"

# Or use script:
./scripts/scrape-with-version.sh https://en.wikipedia.org/wiki/Artificial_intelligence
```

**Expected Results**:
- ✅ Content is extracted
- ✅ Markdown file is created
- ✅ Metadata is included (URL, date, version)
- ✅ Main content is captured (not just navigation)

**Pass/Fail**: [ ]

---

### Test 2.4: Project Initialization

**Objective**: Test research project setup.

**Steps**:
```bash
# Create test project
./scripts/init-research-project.sh "AI Ethics Study" ~/test-projects/ai-ethics

# Verify structure
ls -la ~/test-projects/ai-ethics/
```

**Expected Results**:
- ✅ Project directory created
- ✅ Standard folders created (sources/, reports/, notes/, etc.)
- ✅ README.md created with project info
- ✅ .gitignore created

**Pass/Fail**: [ ]

---

### Test 2.5: Bibliography Generation

**Objective**: Test citation extraction and bibliography creation.

**Steps**:
```bash
# Generate bibliography from test sources
./scripts/generate-bibliography.sh test-data/markdown/ bibliography.md
```

**Expected Results**:
- ✅ Bibliography file created
- ✅ Citations extracted from sources
- ✅ Proper formatting (APA, MLA, or specified style)
- ✅ Alphabetically sorted

**Pass/Fail**: [ ]

---

## Utility Scripts Testing

### Test 3.1: Batch PDF Conversion

**Objective**: Test bulk PDF processing.

**Steps**:
```bash
# Place multiple PDFs in test directory
# Run batch conversion
./scripts/batch-convert-pdfs.sh test-data/pdfs/

# Check results
ls -la test-data/pdfs/*.md
```

**Expected Results**:
- ✅ All PDFs converted
- ✅ Progress shown during conversion
- ✅ Summary report at end
- ✅ Error handling for corrupted PDFs

**Pass/Fail**: [ ]

---

### Test 3.2: Batch URL Scraping

**Objective**: Test bulk web scraping.

**Steps**:
```bash
# Run batch scraping
./scripts/batch-scrape-urls.sh test-data/urls/sample-urls.txt test-data/scraped/

# Verify results
ls -la test-data/scraped/
```

**Expected Results**:
- ✅ All URLs scraped
- ✅ Individual markdown files created
- ✅ Rate limiting respected
- ✅ Failed URLs logged

**Pass/Fail**: [ ]

---

### Test 3.3: Source Search

**Objective**: Test search functionality across sources.

**Steps**:
```bash
# Search for term
./scripts/search-sources.sh test-data/markdown/ "artificial intelligence"
```

**Expected Results**:
- ✅ Relevant files found
- ✅ Context shown for matches
- ✅ Line numbers included
- ✅ Case-insensitive search works

**Pass/Fail**: [ ]

---

### Test 3.4: Conversion Validation

**Objective**: Test quality validation of conversions.

**Steps**:
```bash
# Validate converted files
./scripts/validate-conversion.sh test-data/pdfs/sample.pdf test-data/pdfs/sample.md
```

**Expected Results**:
- ✅ Validation report generated
- ✅ Word count comparison
- ✅ Quality metrics calculated
- ✅ Issues flagged if present

**Pass/Fail**: [ ]

---

### Test 3.5: Change Detection

**Objective**: Test monitoring of source changes.

**Steps**:
```bash
# Initial scan
./scripts/detect-changes.sh test-data/urls/sample-urls.txt

# Modify a source (wait or manually change)
# Run again
./scripts/detect-changes.sh test-data/urls/sample-urls.txt
```

**Expected Results**:
- ✅ Initial hashes stored
- ✅ Changes detected on second run
- ✅ Report shows what changed
- ✅ Unchanged sources skipped

**Pass/Fail**: [ ]

---

### Test 3.6: Report Generation

**Objective**: Test automated report creation.

**Steps**:
```bash
# Generate all reports
./scripts/generate-all-reports.sh test-data/markdown/ test-data/reports/
```

**Expected Results**:
- ✅ Multiple report types generated
- ✅ Templates applied correctly
- ✅ Content organized properly
- ✅ Output files created

**Pass/Fail**: [ ]

---

### Test 3.7: Source Indexing

**Objective**: Test source catalog maintenance.

**Steps**:
```bash
# Update index
./scripts/update-source-index.sh test-data/markdown/ test-data/source-index.json
```

**Expected Results**:
- ✅ JSON index created
- ✅ All sources cataloged
- ✅ Metadata included (date, size, type)
- ✅ Valid JSON format

**Pass/Fail**: [ ]

---

### Test 3.8: Citation Extraction

**Objective**: Test citation extraction from documents.

**Steps**:
```bash
# Extract citations
./scripts/extract-citations.sh test-data/markdown/sample1.md citations.txt
```

**Expected Results**:
- ✅ Citations identified
- ✅ Proper format extracted
- ✅ Duplicates removed
- ✅ Output file created

**Pass/Fail**: [ ]

---

### Test 3.9: Source Archiving

**Objective**: Test archiving of old sources.

**Steps**:
```bash
# Archive sources older than 30 days
./scripts/archive-old-sources.sh test-data/markdown/ 30
```

**Expected Results**:
- ✅ Old sources identified
- ✅ Archive directory created
- ✅ Files moved (not copied)
- ✅ Summary report generated

**Pass/Fail**: [ ]

---

## Documentation Testing

### Test 4.1: README Accuracy

**Objective**: Verify README instructions work.

**Steps**:
1. Follow installation steps in README.md
2. Try quick start examples
3. Verify all links work

**Expected Results**:
- ✅ Installation instructions accurate
- ✅ Examples work as described
- ✅ All links resolve correctly
- ✅ Prerequisites clearly stated

**Pass/Fail**: [ ]

---

### Test 4.2: Guide Completeness

**Objective**: Verify all guides are accessible and accurate.

**Steps**:
```bash
# Check all guides exist
ls -la .bob/skills/research-assistant/guides/

# Verify guide count matches documentation
find .bob/skills/research-assistant/guides/ -name "*.md" | wc -l
```

**Expected Results**:
- ✅ All 10 guides present
- ✅ Guides are readable
- ✅ Examples in guides work
- ✅ Cross-references valid

**Pass/Fail**: [ ]

---

### Test 4.3: Script Documentation

**Objective**: Verify script documentation is accurate.

**Steps**:
```bash
# Check script README
cat scripts/README.md

# Verify all scripts documented
ls scripts/*.sh | wc -l
```

**Expected Results**:
- ✅ All 13 scripts documented
- ✅ Usage examples provided
- ✅ Parameters explained
- ✅ Examples work

**Pass/Fail**: [ ]

---

### Test 4.4: Template Validation

**Objective**: Verify report templates are usable.

**Steps**:
```bash
# Check templates
ls -la .bob/skills/research-assistant/templates/

# Try using a template
cp .bob/skills/research-assistant/templates/research-report.md test-report.md
```

**Expected Results**:
- ✅ All 5 templates present
- ✅ Templates are well-formatted
- ✅ Placeholders clearly marked
- ✅ Instructions included

**Pass/Fail**: [ ]

---

## Integration Testing

### Test 5.1: End-to-End Research Workflow

**Objective**: Test complete research workflow.

**Steps**:
```bash
# 1. Initialize project
./scripts/init-research-project.sh "Integration Test" ~/test-integration

# 2. Add sources
cd ~/test-integration
./scripts/batch-scrape-urls.sh ../test-data/urls/sample-urls.txt sources/web/

# 3. Convert PDFs
./scripts/batch-convert-pdfs.sh ../test-data/pdfs/ sources/documents/

# 4. Generate bibliography
./scripts/generate-bibliography.sh sources/ bibliography.md

# 5. Create reports
./scripts/generate-all-reports.sh sources/ reports/

# 6. Update index
./scripts/update-source-index.sh sources/ source-index.json
```

**Expected Results**:
- ✅ All steps complete without errors
- ✅ Project structure maintained
- ✅ All outputs generated
- ✅ Data flows correctly between steps

**Pass/Fail**: [ ]

---

### Test 5.2: Bob Conversation Flow

**Objective**: Test natural conversation with Bob.

**Steps**:
1. Start Bob
2. Say: "I need to research AI ethics. Can you help me set up a project?"
3. Follow Bob's guidance
4. Ask: "Can you scrape content from [URL]?"
5. Ask: "Generate a bibliography from my sources"
6. Ask: "Create a research report"

**Expected Results**:
- ✅ Bob understands requests
- ✅ Skill activates appropriately
- ✅ Tasks complete successfully
- ✅ Bob provides helpful feedback

**Pass/Fail**: [ ]

---

## Edge Cases and Error Handling

### Test 6.1: Invalid PDF

**Objective**: Test handling of corrupted PDFs.

**Steps**:
```bash
# Create invalid PDF
echo "Not a real PDF" > test-data/pdfs/invalid.pdf

# Try to convert
./scripts/batch-convert-pdfs.sh test-data/pdfs/
```

**Expected Results**:
- ✅ Error caught gracefully
- ✅ Error message is clear
- ✅ Other PDFs still processed
- ✅ Script doesn't crash

**Pass/Fail**: [ ]

---

### Test 6.2: Network Failure

**Objective**: Test handling of network errors.

**Steps**:
```bash
# Try to scrape invalid URL
./scripts/scrape-with-version.sh https://this-url-does-not-exist-12345.com
```

**Expected Results**:
- ✅ Error caught gracefully
- ✅ Timeout handled properly
- ✅ Clear error message
- ✅ No partial files created

**Pass/Fail**: [ ]

---

### Test 6.3: Missing Dependencies

**Objective**: Test behavior when dependencies are missing.

**Steps**:
```bash
# Temporarily rename Python package
# (Don't actually do this in production)
# Instead, check error messages in install.sh

# Run installation without Python
PATH=/usr/bin:/bin ./install.sh
```

**Expected Results**:
- ✅ Missing dependencies detected
- ✅ Clear error messages
- ✅ Installation stops gracefully
- ✅ Instructions provided

**Pass/Fail**: [ ]

---

### Test 6.4: Large File Handling

**Objective**: Test handling of very large files.

**Steps**:
```bash
# Create large test file (if available)
# Or use actual large PDF

# Try to convert
./scripts/batch-convert-pdfs.sh test-data/large-pdfs/
```

**Expected Results**:
- ✅ Large files processed (may be slow)
- ✅ Memory usage reasonable
- ✅ Progress indicators work
- ✅ No crashes

**Pass/Fail**: [ ]

---

### Test 6.5: Special Characters

**Objective**: Test handling of special characters in filenames.

**Steps**:
```bash
# Create files with special characters
touch "test-data/markdown/file with spaces.md"
touch "test-data/markdown/file-with-émojis-🎉.md"

# Run search
./scripts/search-sources.sh test-data/markdown/ "test"
```

**Expected Results**:
- ✅ Files processed correctly
- ✅ No path errors
- ✅ Output readable
- ✅ Special chars preserved

**Pass/Fail**: [ ]

---

## Performance Testing

### Test 7.1: Batch Processing Speed

**Objective**: Measure performance of batch operations.

**Steps**:
```bash
# Time batch conversion
time ./scripts/batch-convert-pdfs.sh test-data/pdfs/

# Time batch scraping
time ./scripts/batch-scrape-urls.sh test-data/urls/sample-urls.txt test-data/scraped/
```

**Expected Results**:
- ✅ Reasonable processing time
- ✅ Progress indicators accurate
- ✅ No memory leaks
- ✅ CPU usage acceptable

**Metrics**:
- PDFs per minute: _____
- URLs per minute: _____
- Memory usage: _____

**Pass/Fail**: [ ]

---

### Test 7.2: Search Performance

**Objective**: Test search speed across many files.

**Steps**:
```bash
# Create many test files
for i in {1..100}; do
  echo "Test content $i with keyword" > test-data/markdown/test$i.md
done

# Time search
time ./scripts/search-sources.sh test-data/markdown/ "keyword"
```

**Expected Results**:
- ✅ Search completes in reasonable time
- ✅ All matches found
- ✅ Results displayed clearly

**Metrics**:
- Files searched: _____
- Time taken: _____
- Results found: _____

**Pass/Fail**: [ ]

---

## Test Results Template

### Summary

| Category | Tests | Passed | Failed | Skipped |
|----------|-------|--------|--------|---------|
| Installation | 3 | | | |
| Core Functionality | 5 | | | |
| Utility Scripts | 9 | | | |
| Documentation | 4 | | | |
| Integration | 2 | | | |
| Edge Cases | 5 | | | |
| Performance | 2 | | | |
| **TOTAL** | **30** | | | |

### Critical Issues

List any critical issues found:
1. 
2. 
3. 

### Minor Issues

List any minor issues found:
1. 
2. 
3. 

### Recommendations

Based on testing:
1. 
2. 
3. 

### Test Environment

- **OS**: 
- **Python Version**: 
- **Node Version**: 
- **Bob Version**: 
- **Test Date**: 
- **Tester**: 

---

## Quick Test Script

For rapid validation, use this script:

```bash
#!/bin/bash
# quick-test.sh - Run essential tests

echo "🧪 Research Assistant Quick Test"
echo "================================"

# Test 1: Installation
echo "1. Testing installation..."
./install.sh > /dev/null 2>&1 && echo "✓ Installation OK" || echo "✗ Installation FAILED"

# Test 2: Dependencies
echo "2. Testing dependencies..."
python3 -c "import docling, crawl4ai" 2>/dev/null && echo "✓ Dependencies OK" || echo "✗ Dependencies FAILED"

# Test 3: Scripts exist
echo "3. Testing scripts..."
[ -f scripts/init-research-project.sh ] && echo "✓ Scripts OK" || echo "✗ Scripts FAILED"

# Test 4: Documentation
echo "4. Testing documentation..."
[ -f .bob/skills/research-assistant/README.md ] && echo "✓ Documentation OK" || echo "✗ Documentation FAILED"

# Test 5: Skill definition
echo "5. Testing skill definition..."
[ -f .bob/skills/research-assistant/SKILL.md ] && echo "✓ Skill definition OK" || echo "✗ Skill definition FAILED"

echo ""
echo "Quick test complete!"
```

Save as `quick-test.sh`, make executable, and run:
```bash
chmod +x quick-test.sh
./quick-test.sh
```

---

**Last Updated**: 2026-06-17
**Version**: 1.0.0