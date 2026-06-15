# Version Control Guide

This guide explains how to track research iterations, maintain version history, and manage changes to your research projects.

## Overview

Version control for research projects helps you:
- **Track Progress**: See how analysis evolved over time
- **Compare Iterations**: Understand what changed between versions
- **Rollback Changes**: Revert to previous versions if needed
- **Collaborate**: Work with others without conflicts
- **Document Decisions**: Record why changes were made

## Version Control Strategies

### Strategy 1: Git-Based Version Control

**Best for**: Complete project history, collaboration, branching

```bash
# Initialize Git repository
cd research/api-management-trends-2024
git init
git add .
git commit -m "feat: initial project setup"

# Track changes
git add analysis.md
git commit -m "docs: add competitive analysis section"

# Create branches for different approaches
git checkout -b alternative-analysis
# Make changes
git commit -m "docs: explore alternative analysis framework"

# Merge back to main
git checkout main
git merge alternative-analysis
```

**Commit Message Convention**:
```
feat: add new analysis section
docs: update findings based on new source
refactor: reorganize report structure
fix: correct performance metrics
chore: update source index
```

### Strategy 2: File-Based Versioning

**Best for**: Simple projects, quick iterations, no Git needed

```bash
# Version naming convention
research/api-management-trends-2024/
├── report-v1.md          # First complete draft
├── report-v2.md          # After first review
├── report-v3.md          # After incorporating feedback
├── report-final.md       # Final version
└── archive/
    ├── report-draft.md   # Early draft
    └── report-v1-old.md  # Superseded version
```

**Version Naming**:
```
✓ report-v1.md, report-v2.md, report-v3.md
✓ analysis-2024-06-12.md, analysis-2024-06-15.md
✓ report-draft.md, report-review.md, report-final.md

✗ report-new.md, report-final-final.md
✗ report1.md, report2.md
```

### Strategy 3: Hybrid Approach

**Best for**: Combining Git for project and file versions for major milestones

```bash
# Use Git for daily work
git commit -m "docs: update vendor comparison"

# Create versioned snapshots at milestones
cp report.md report-v1-initial-draft.md
git add report-v1-initial-draft.md
git commit -m "milestone: v1 initial draft complete"

# Continue working
git commit -m "docs: add security analysis"

# Create next milestone
cp report.md report-v2-review-ready.md
git add report-v2-review-ready.md
git commit -m "milestone: v2 ready for review"
```

## Version Tracking Patterns

### Pattern 1: Changelog

Maintain a changelog to track what changed:

```markdown
# CHANGELOG.md

## [v3] - 2024-06-15

### Added
- Security analysis section
- Cost comparison matrix
- Implementation complexity assessment

### Changed
- Updated performance metrics with latest data
- Revised vendor recommendations based on new findings
- Reorganized executive summary for clarity

### Removed
- Outdated 2023 pricing information
- Deprecated API gateway features

## [v2] - 2024-06-13

### Added
- Competitive analysis section
- Vendor comparison matrix

### Changed
- Expanded trend analysis with additional sources
- Updated market overview

## [v1] - 2024-06-12

### Added
- Initial project structure
- Market overview
- Trend identification
```

### Pattern 2: Version Metadata

Add version information to documents:

```markdown
---
version: 3.0
date: 2024-06-15
status: review
previous_version: report-v2.md
changes:
  - Added security analysis
  - Updated performance metrics
  - Revised recommendations
reviewers:
  - John Doe
  - Jane Smith
---

# API Management Trends 2024

**Version**: 3.0  
**Last Updated**: June 15, 2024  
**Status**: Under Review
```

### Pattern 3: Diff Tracking

Track specific changes between versions:

```bash
# Compare versions
diff -u report-v2.md report-v3.md > changes-v2-to-v3.diff

# Or use Git
git diff report-v2.md report-v3.md > changes-v2-to-v3.diff

# Create human-readable change summary
cat > changes-v2-to-v3.md << 'EOF'
# Changes from v2 to v3

## Major Changes
1. Added security analysis section (lines 245-312)
2. Updated performance metrics (lines 156-178)
3. Revised vendor recommendations (lines 420-445)

## Minor Changes
- Fixed typos in executive summary
- Updated source citations
- Reformatted comparison tables

## Removed
- Outdated pricing from 2023
- Deprecated feature comparisons
EOF
```

## Git Workflow for Research

### Basic Workflow

```bash
# 1. Start new research session
git pull  # Get latest changes if collaborating

# 2. Make changes
# Edit files...

# 3. Review changes
git status
git diff

# 4. Stage changes
git add analysis.md sources/new-source.md

# 5. Commit with descriptive message
git commit -m "docs: add gap analysis section

- Identified 3 critical information gaps
- Proposed additional sources to address gaps
- Updated research plan"

# 6. Push if collaborating
git push origin main
```

### Branching for Experiments

```bash
# Create branch for experimental analysis
git checkout -b experiment/alternative-framework

# Make experimental changes
# Edit files...
git commit -m "docs: try alternative analysis framework"

# If experiment works, merge to main
git checkout main
git merge experiment/alternative-framework

# If experiment doesn't work, abandon branch
git checkout main
git branch -D experiment/alternative-framework
```

### Tagging Milestones

```bash
# Tag important versions
git tag -a v1.0 -m "Initial draft complete"
git tag -a v2.0 -m "Review version"
git tag -a v3.0 -m "Final version"

# List tags
git tag -l

# Checkout specific version
git checkout v2.0

# Return to latest
git checkout main
```

## Version Comparison

### Compare Two Versions

```bash
#!/bin/bash
# compare-versions.sh

VERSION1="$1"
VERSION2="$2"

echo "# Version Comparison: $VERSION1 vs $VERSION2"
echo ""
echo "## File Changes"
echo ""

# Show changed files
git diff --name-status "$VERSION1" "$VERSION2"

echo ""
echo "## Content Changes"
echo ""

# Show detailed changes
git diff "$VERSION1" "$VERSION2" -- "*.md"

echo ""
echo "## Statistics"
echo ""

# Show change statistics
git diff --stat "$VERSION1" "$VERSION2"
```

### Generate Change Report

```bash
#!/bin/bash
# generate-change-report.sh

FROM_VERSION="$1"
TO_VERSION="$2"
OUTPUT="changes-${FROM_VERSION}-to-${TO_VERSION}.md"

cat > "$OUTPUT" << EOF
# Change Report: $FROM_VERSION → $TO_VERSION

**Generated**: $(date +"%Y-%m-%d %H:%M")

## Summary

EOF

# Add statistics
git diff --stat "$FROM_VERSION" "$TO_VERSION" >> "$OUTPUT"

cat >> "$OUTPUT" << EOF

## Detailed Changes

EOF

# Add detailed changes for markdown files
git diff "$FROM_VERSION" "$TO_VERSION" -- "*.md" >> "$OUTPUT"

echo "Change report generated: $OUTPUT"
```

## Rollback Strategies

### Rollback with Git

```bash
# View commit history
git log --oneline

# Rollback to specific commit (keep changes as uncommitted)
git reset <commit-hash>

# Rollback and discard changes
git reset --hard <commit-hash>

# Rollback specific file
git checkout <commit-hash> -- path/to/file.md

# Create new commit that undoes changes
git revert <commit-hash>
```

### Rollback with File Versions

```bash
# Restore from versioned file
cp report-v2.md report.md

# Or restore from archive
cp archive/report-v1.md report.md

# Document the rollback
cat >> CHANGELOG.md << 'EOF'
## [v4] - 2024-06-16

### Reverted
- Rolled back to v2 analysis framework
- Reason: v3 approach didn't align with stakeholder needs
EOF
```

## Collaboration Workflows

### Single Researcher

```bash
# Simple linear workflow
git add .
git commit -m "docs: daily progress update"
git push
```

### Multiple Researchers

```bash
# Feature branch workflow
git checkout -b feature/security-analysis
# Work on security analysis
git commit -m "docs: add security analysis"
git push origin feature/security-analysis

# Create pull request for review
# After approval, merge to main
git checkout main
git merge feature/security-analysis
```

### Review Process

```bash
# Create review branch
git checkout -b review/v2-feedback
# Incorporate feedback
git commit -m "docs: address review comments"
git push origin review/v2-feedback

# After final approval
git checkout main
git merge review/v2-feedback
git tag -a v2.0-final -m "Final version after review"
```

## Version Control Best Practices

### 1. Commit Frequently

```bash
# Good: Small, focused commits
git commit -m "docs: add performance comparison section"
git commit -m "docs: update vendor pricing data"
git commit -m "fix: correct throughput metrics"

# Bad: Large, unfocused commits
git commit -m "updated everything"
```

### 2. Write Descriptive Messages

```bash
# Good: Clear, descriptive
git commit -m "docs: add security analysis section

- Analyzed authentication mechanisms
- Compared authorization models
- Evaluated encryption standards
- Added security recommendations"

# Bad: Vague
git commit -m "updates"
git commit -m "changes"
```

### 3. Use Branches for Experiments

```bash
# Experiment with new approach
git checkout -b experiment/new-framework

# If it works
git checkout main
git merge experiment/new-framework

# If it doesn't
git checkout main
git branch -D experiment/new-framework
```

### 4. Tag Important Versions

```bash
# Tag milestones
git tag -a draft-complete -m "Initial draft finished"
git tag -a review-ready -m "Ready for stakeholder review"
git tag -a final -m "Final approved version"
```

### 5. Keep Archive Clean

```bash
# Move old versions to archive
mkdir -p archive/2024-06
mv report-v1.md archive/2024-06/
mv report-v2.md archive/2024-06/

# Document what's archived
cat > archive/2024-06/README.md << 'EOF'
# Archived Versions - June 2024

- report-v1.md: Initial draft (superseded by v3)
- report-v2.md: Review version (superseded by v3)

Current version: report-v3.md (in parent directory)
EOF
```

## Version Control Scripts

### Auto-Backup Script

```bash
#!/bin/bash
# auto-backup.sh

PROJECT_DIR="research/api-management-trends-2024"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

mkdir -p "$BACKUP_DIR"

# Backup key files
cp "$PROJECT_DIR/report.md" "$BACKUP_DIR/report-$TIMESTAMP.md"
cp "$PROJECT_DIR/analysis.md" "$BACKUP_DIR/analysis-$TIMESTAMP.md"

# Keep only last 10 backups
cd "$BACKUP_DIR"
ls -t report-*.md | tail -n +11 | xargs rm -f
ls -t analysis-*.md | tail -n +11 | xargs rm -f

echo "Backup created: $TIMESTAMP"
```

### Version Snapshot Script

```bash
#!/bin/bash
# create-snapshot.sh

VERSION="$1"
DESCRIPTION="$2"

if [ -z "$VERSION" ]; then
  echo "Usage: ./create-snapshot.sh <version> <description>"
  exit 1
fi

# Create snapshot directory
SNAPSHOT_DIR="snapshots/v$VERSION"
mkdir -p "$SNAPSHOT_DIR"

# Copy current state
cp -r sources "$SNAPSHOT_DIR/"
cp -r analysis "$SNAPSHOT_DIR/"
cp report.md "$SNAPSHOT_DIR/"
cp README.md "$SNAPSHOT_DIR/"

# Create snapshot metadata
cat > "$SNAPSHOT_DIR/SNAPSHOT.md" << EOF
# Snapshot v$VERSION

**Created**: $(date +"%Y-%m-%d %H:%M")
**Description**: $DESCRIPTION

## Contents
- sources/: All source materials
- analysis/: Analysis documents
- report.md: Main report
- README.md: Project documentation
EOF

echo "Snapshot v$VERSION created in $SNAPSHOT_DIR"
```

## Integration with Research Workflow

### Daily Workflow

```bash
# Morning: Start work
git pull
./auto-backup.sh

# During day: Commit progress
git add analysis.md
git commit -m "docs: add vendor comparison section"

# Evening: End of day
git add .
git commit -m "docs: daily progress - completed performance analysis"
git push
```

### Milestone Workflow

```bash
# Complete major milestone
git add .
git commit -m "milestone: initial draft complete"
git tag -a v1.0 -m "Initial draft"

# Create snapshot
./create-snapshot.sh 1.0 "Initial draft complete"

# Update changelog
cat >> CHANGELOG.md << 'EOF'
## [v1.0] - 2024-06-12
- Initial draft complete
- All sections written
- Ready for internal review
EOF

git add CHANGELOG.md
git commit -m "docs: update changelog for v1.0"
git push --tags
```

## Related Documentation

- [Project Initialization Guide](project-initialization.md) - Setting up version control
- [Citation Management Guide](citation-management.md) - Tracking source versions
- [Common Commands Guide](common-commands.md) - Git commands reference

## Summary

Effective version control:
- Tracks research evolution
- Enables comparison and rollback
- Supports collaboration
- Documents decision-making
- Maintains project history

Choose the strategy that fits your workflow: Git for comprehensive tracking, file versions for simplicity, or hybrid for flexibility.