# Project Initialization Guide

This guide covers how to initialize research topics and projects in the two-type internal knowledge model.

## Overview

The workspace has two types of human-authored work, each with a distinct purpose:

| Type | Folder | Purpose | Structure |
|------|--------|---------|-----------|
| Research topic | `research/[topic]/` | Build understanding and a point of view on a topic | Unrestricted — grows organically |
| Project | `projects/[name]/` | Create a specific deliverable | Flat — no subdirectories |

Both are **internal knowledge** and are completely separate from:
- `wiki/` — external knowledge, sourced from documents and web scraping
- `inbox/` — staging area for wiki ingest, never used for research or project work
- `sources/` — converted documents, shared across everything

## Quick Start

### Start a Research Topic

Ask Bob: *"Start a research topic on [topic]"*

Bob will ask: topic name, primary goal, and key questions. Then:

```bash
mkdir -p research/[topic]
touch research/[topic]/goals.md
```

`goals.md` starter template:

```markdown
# Research Goals: [Topic]

**Created**: YYYY-MM-DD

## Topic
What area are you exploring?

## Objectives
What are you trying to learn or understand?

## Key Questions
1.
2.
3.

## Decisions This Informs
What will this research be used for?

## Scope
What's in and out of scope?
```

From there, the folder grows however is useful — add notes, sub-topic folders, analysis files, anything.

### Start a Project

Ask Bob: *"Start a project for [name]"*

Bob will ask: project name, deliverable description, and audience. Then:

```bash
mkdir -p projects/[name]
touch projects/[name]/brief.md
```

`brief.md` starter template:

```markdown
# Project Brief: [Name]

**Created**: YYYY-MM-DD

## Deliverable
What are you creating? (e.g. executive brief, competitive comparison, slide deck)

## Audience
Who is this for?

## Source Materials
Which wiki pages, sources, or research topics will you draw from?

## Deadline / Context
Any timing or context constraints?
```

Projects are flat — `projects/[name]/` contains only files, no subdirectories.

## Workspace Structure

```
inbox/            # Staging area — external knowledge ingest only
wiki/             # External knowledge — sourced from documents and web
sources/          # Shared converted documents and scraped pages
originals/        # Original immutable files
research/         # Internal knowledge — exploratory topic work (unrestricted)
projects/         # Internal knowledge — deliverable work (flat)
```

**One-time repo setup:**
```bash
mkdir -p sources originals wiki inbox/.archive projects
```

## Research Topics vs Projects

### Research topics (`research/`)

- **When to use**: Building understanding, exploring a space, developing a point of view
- **Structure**: No restrictions — add files and folders as the work evolves
- **Starter file**: `goals.md` only
- **Grows via**: Notes, sub-topic folders, imported wiki findings, analysis files
- **Bidirectional with wiki**: Research can draw from wiki; research outputs can be filed back to the wiki via the inbox review gate

**Example layout after growth:**
```
research/api-management/
├── goals.md
├── notes.md
├── vendors/
│   ├── kong.md
│   └── apigee.md
└── analysis.md
```

### Projects (`projects/`)

- **When to use**: Creating a specific deliverable — brief, report, comparison, presentation
- **Structure**: Flat — files only, no subdirectories
- **Starter file**: `brief.md` only
- **Grows via**: Additional flat files (e.g. `draft.md`, `outline.md`, `output.docx`)
- **Bidirectional with wiki**: Project outputs can be filed to the wiki via the inbox review gate

**Example layout:**
```
projects/q3-competitive-brief/
├── brief.md
├── outline.md
└── draft.md
```

## Filing Work Back to the Wiki

Both research topics and projects can surface reusable knowledge. To file a finding:

Ask Bob: *"File this to the wiki"* or *"Add [finding] to the wiki"*

Bob will draft an inbox entry from the content and walk through the standard inbox review gate — same as any other ingest.

## Version Control

Follow the commit prefix conventions:

```bash
# New research topic
git add research/api-management/
git commit -m "research: api-management — initialize goals"

# Research topic update
git add research/api-management/
git commit -m "research: api-management — add vendor notes"

# New project
git add projects/q3-brief/
git commit -m "project: q3-brief — initialize brief"

# Project update
git add projects/q3-brief/
git commit -m "project: q3-brief — draft executive summary"
```

## Best Practices

### Naming

- Use lowercase with hyphens: `api-management`, `q3-competitive-brief`
- Research topics: noun phrase describing the area (`cloud-security`, `api-management`)
- Projects: short deliverable label (`q3-brief`, `gartner-comparison`, `board-update`)

### Keep Work Separate

- Never put a research topic folder inside `projects/` or vice versa
- Never create research or project folders as a side effect of importing a document
- Importing a document about "agentic AI" does NOT create `research/agentic-ai/`

### Filing to Wiki

- File synthesis and durable findings, not raw notes
- Use the inbox review gate — don't write directly to `wiki/`

## Related Documentation

- [Source Organization Guide](source-organization.md)
- [Version Control Guide](version-control.md)
- [Main SKILL.md](../SKILL.md) — Complete skill documentation
