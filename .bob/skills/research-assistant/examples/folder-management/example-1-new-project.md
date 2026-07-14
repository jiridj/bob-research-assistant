# Example 1: Creating a Research Topic and a Project

This example demonstrates how to initialize both a research topic and a project — the two types of internal work in the workspace.

## Scenario

A product manager wants to:
1. Explore API management trends (exploratory → research topic)
2. Produce a competitive brief for the Q3 strategy review (specific deliverable → project)

These are two separate operations. Importing analyst reports does neither — that goes to the wiki pipeline via inbox.

## Example A: Start a Research Topic

### User Request
```
User: "Start a research topic on API management"
```

### Bob's Response

```
Bob: "What's the primary goal of this research? And what are the key questions you want to answer?"

User: "I want to understand the competitive landscape and identify where our product is differentiated. Key questions: who are the main players, what are the buying criteria, how is AI changing the market?"

Bob: Creating research topic...
```

### Bob's Actions

```bash
mkdir -p research/api-management
touch research/api-management/goals.md
```

```
Bob: ✓ Created research topic: research/api-management/
     └── goals.md

I've pre-filled goals.md with your topic, objective, and questions. Edit it freely — then add notes, analysis, or sub-folders as the work grows.

Suggested commit:
  git add research/api-management/
  git commit -m "research: api-management — initialize goals"

Would you like to start by importing some analyst reports into the wiki?"
```

### Resulting Structure

```
research/api-management/
└── goals.md
```

After work begins, it might grow to:

```
research/api-management/
├── goals.md
├── notes.md
├── vendors/
│   ├── kong.md
│   └── apigee.md
└── synthesis.md
```

No restrictions on how it grows.

---

## Example B: Start a Project

### User Request
```
User: "Start a project for the Q3 competitive brief"
```

### Bob's Response

```
Bob: "What's the deliverable, and who is the audience?"

User: "A 3-page executive brief comparing our API gateway against Kong and Apigee. Audience is the VP of Product and CTO. I'll draw from the wiki and the api-management research topic."

Bob: Creating project...
```

### Bob's Actions

```bash
mkdir -p projects/q3-competitive-brief
touch projects/q3-competitive-brief/brief.md
```

```
Bob: ✓ Created project: projects/q3-competitive-brief/
     └── brief.md

I've pre-filled brief.md with your deliverable, audience, and source materials. Projects are flat — add files directly here, no subdirectories.

Suggested commit:
  git add projects/q3-competitive-brief/
  git commit -m "project: q3-competitive-brief — initialize brief"

Ready to draft an outline?"
```

### Resulting Structure

```
projects/q3-competitive-brief/
├── brief.md
├── outline.md
└── draft.md
```

All files at the top level — no subdirectories.

---

## Key Takeaways

1. **Research topics** are for building understanding. They grow organically — no file restrictions.
2. **Projects** are for specific deliverables. They stay flat — no subdirectories.
3. **Importing analyst reports** does neither — it goes to `inbox/` for wiki review.
4. Bob asks questions before creating either type, then creates only the starter file.
5. Suggested commits use `research:` or `project:` prefixes to distinguish layers in git history.

## Related Examples

- [Example 2: Organizing Sources](example-2-organizing-sources.md) — managing `sources/` and the wiki pipeline
- [Project Initialization Guide](../../guides/project-initialization.md) — full guide
