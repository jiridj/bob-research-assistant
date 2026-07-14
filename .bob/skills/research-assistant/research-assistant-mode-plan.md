# Research Assistant — Skill Description + Custom Mode Plan

## Overview

The `research-assistant` skill is not reliably auto-activated in Agent mode because its `description`
frontmatter lacks specific trigger phrases. Bob scores skill relevance against that description, and
vague noun-heavy descriptions lose to built-in tools like `read_file` that appear more directly
relevant. Two changes will fix this:

1. **Rewrite the skill `description`** with explicit trigger phrases that match how users phrase
   research requests.
2. **Create a dedicated custom mode** that bakes the skill's Hard Rules into the mode's
   `roleDefinition`/`customInstructions`, so the workflow is always active when the user
   selects it — no auto-activation required.

These are independent sub-tasks that can be reviewed separately.

---

## Sub-Task 1 — Improve Skill Description Trigger Phrases

**Status:** [ ] pending

### Intent
The `description` field in SKILL.md frontmatter is the primary signal Bob uses to decide whether
to auto-activate a skill. The current description is noun-heavy and generic. Adding explicit
trigger phrases — matching how users actually phrase requests — raises the hit rate in Agent mode
without any structural change.

### Expected Outcomes
- The `description` field in `.bob/skills/research-assistant/SKILL.md` frontmatter contains
  explicit trigger phrases covering the most common research request patterns.
- In Agent mode, saying "import this file", "convert this PDF", "scrape this URL", "add to wiki",
  or "start a research project" reliably activates the skill without the user having to say
  "use the research-assistant skill".

### Todo List
1. Open `.bob/skills/research-assistant/SKILL.md`
2. Replace the `description` frontmatter value (line 3) with a new version that:
   - Keeps the high-level summary
   - Adds an explicit trigger phrase list covering: "import", "convert PDF", "convert DOCX",
     "scrape URL", "add to wiki", "ingest", "merge inbox", "start research project",
     "build wiki", "analyse document", "summarise document", "generate report"
   - Follows the pattern used by well-triggering skills (e.g. `github-cli`, `web-research`)

### Relevant Context
- File: `.bob/skills/research-assistant/SKILL.md`, lines 1–4
- Current description: `"Comprehensive research workflow automation with document conversion,
  web scraping, analysis, report generation, and persistent wiki knowledge base with
  human-in-the-loop review"`
- Reference pattern (github-cli): includes "Trigger on: GitHub, gh, repositories, repos, ..."
- Reference pattern (web-research): includes "Trigger phrases: search the web, look up, ..."

---

## Sub-Task 2 — Create Research Assistant Custom Mode

**Status:** [ ] pending

### Intent
A custom mode bakes the research workflow into the mode's system prompt so the Hard Rules are
always active when the user selects it. This is the strongest reliability guarantee — no
auto-activation ambiguity.

### Expected Outcomes
- A new `research-assistant` mode entry exists in `.bob/custom_modes.yaml` (workspace scope).
- When selected, the mode's persona and Hard Rules are always in context.
- The mode's `whenToUse` tooltip covers all research trigger phrases so the mode picker
  surfaces it at the right time.
- The mode has correct tool groups: `read`, `edit`, `execute`, `mcp`, `skill`, `subagent`.

### Todo List
1. Check if `.bob/custom_modes.yaml` exists. If it does, read it first to avoid overwriting.
2. Draft the mode entry:
   - `slug`: `research-assistant`
   - `name`: `🔬 Research Assistant`
   - `roleDefinition`: High-density research assistant persona (from SKILL.md "Persona" section)
     + inline Hard Rules (from SKILL.md "Hard Rules" section) so they are always loaded.
   - `customInstructions`: Instruction to call `use_skill` with `research-assistant` at the
     start of every session to load the full workflow detail.
   - `whenToUse`: Covers all trigger phrases — import, convert, scrape, wiki, ingest, merge,
     research project, report generation.
   - `groups`: `read`, `edit`, `execute`, `mcp`, `skill`, `subagent`
3. Write `.bob/custom_modes.yaml` with the new entry (create file if it doesn't exist).
4. Verify the slug matches `^[a-zA-Z0-9-]+$` and no duplicate exists.

### Relevant Context
- File to create: `.bob/custom_modes.yaml` (workspace scope — does not yet exist)
- Hard Rules source: `.bob/skills/research-assistant/SKILL.md`, lines 8–19
- Persona source: `.bob/skills/research-assistant/SKILL.md`, lines 21–33
- Global modes file for reference: `~/.bob/settings/custom_modes.yaml` (contains
  `winning-products` mode — note: that mode has `command` instead of `execute` in its groups,
  which is a silent bug; do NOT replicate that mistake here)
- Tool groups must use exact names: `read`, `edit`, `execute`, `mcp`, `skill`, `subagent`

---

## Notes

- Sub-task 1 alone improves Agent mode reliability but does not guarantee it.
- Sub-task 2 alone solves the problem for users who select the mode, but doesn't help
  Agent mode auto-detection.
- Together they provide full coverage: best-effort auto-activation in Agent mode + guaranteed
  activation when the user picks the dedicated mode.
- The two sub-tasks are independent and can be implemented in either order.
