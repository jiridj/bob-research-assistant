# Research / Project Split Plan

## Overview

The skill currently treats all human-authored work as a single `research/[name]/` type — flat, three files, no structural distinction between exploratory research and deliverable-focused project work. This plan splits them into two clearly differentiated workspace types:

- **`research/[topic]/`** — Building understanding and a point of view on a topic. Grows organically, no file restrictions. Bidirectional with the wiki: consumes from it and can push synthesis back via the inbox flow.
- **`projects/[name]/`** — Specific content creation tasks with a defined deliverable. Flat (no subdirectories). Also bidirectional with the wiki when work surfaces reusable knowledge.

The wiki (`wiki/`) remains **external knowledge** — sourced from documents, web scraping, and analyst reports. Research and projects are **internal knowledge** — authored perspectives and deliverables. They are independent layers and must never be conflated.

Branch-and-PR collaboration is the intended model for multi-contributor repos.

---

## Sub-Tasks

### 1. Update the folder structure definition in SKILL.md

**Intent:** Replace the single `research/` block in the Project Initialization section with the two-type model. Make the purpose and rules of each type explicit. Update the one-time repo setup command.

**Expected Outcomes:**
- The structure block clearly shows `research/`, `projects/`, `wiki/`, `sources/`, `originals/`, `inbox/` as sibling top-level folders.
- Each type has a concise purpose statement and its own rules.
- The repo setup command includes `mkdir -p projects`.
- The old "per-project setup" block is replaced with separate "start a research topic" and "start a project" blocks.

**Todo List:**
1. In the `### Project Initialization` section, replace the structure diagram and setup commands with the new two-type layout.
2. Add a purpose sentence for `research/`: *exploratory, no file restrictions, grows organically, bidirectional with wiki via inbox.*
3. Add a purpose sentence for `projects/`: *task-scoped deliverable work, flat (no subdirectories), bidirectional with wiki via inbox.*
4. Update one-time repo setup: `mkdir -p sources originals wiki inbox/.archive projects`
5. Add a "start a research topic" setup block: Bob asks topic + goals questions → creates `research/[topic]/goals.md` only.
6. Add a "start a project" setup block: Bob asks name + brief → creates `projects/[name]/brief.md` only.

**Relevant Context:**
- [`SKILL.md` lines 71–145](.bob/skills/research-assistant/SKILL.md) — Project Initialization section
- [`guides/project-initialization.md`](.bob/skills/research-assistant/guides/project-initialization.md) — will be updated in sub-task 5

**Status:** [x] done

---

### 2. Update Hard Rules in SKILL.md

**Intent:** The existing Hard Rules enforce wiki/inbox separation from research but use `research/` as a catch-all. Rules 4 and 5 need to be updated to reference both `research/` and `projects/` explicitly, and a new rule should clarify the wiki-vs-internal knowledge boundary.

**Expected Outcomes:**
- Rule 4 states that ingest never creates a `research/` or `projects/` folder.
- Rule 5 states that `projects/[name]/` is flat; `research/[topic]/` is unrestricted.
- A new Rule 6 states: wiki = external knowledge (sourced from documents/web); research + projects = internal knowledge (human-authored). Never mix.

**Todo List:**
1. Update Hard Rule 4 to name both `research/` and `projects/`.
2. Update Hard Rule 5 to split the flatness constraint: projects are flat, research is unrestricted.
3. Add Hard Rule 6 defining the external/internal knowledge boundary.

**Relevant Context:**
- [`SKILL.md` lines 8–20](.bob/skills/research-assistant/SKILL.md) — Hard Rules section

**Status:** [x] done

---

### 3. Update the Other Commands section and Critical Distinctions block

**Intent:** The command list and critical distinctions block reference only `research/`. They need entries and clarifications for `projects/` too. The bidirectional wiki flow (research/project → wiki via inbox) needs to be documented as a command.

**Expected Outcomes:**
- "Start a project on [topic]" command updated to route to `research/[topic]/` (exploratory).
- New "Start a project for [name]" command creates `projects/[name]/brief.md`.
- "File to wiki" command documented for both research and project outputs.
- Critical Distinctions block updated to cover three independent operations: import/ingest, start research, start project.

**Todo List:**
1. Update the `"Start a project on [topic]"` entry to clarify it creates a research topic, not a project.
2. Add `"Start a project for [name]"` entry → creates `projects/[name]/brief.md`.
3. Add `"File [finding/output] to wiki"` entry → drafts inbox entry from research or project content.
4. Rewrite the Critical Distinctions block to cover all three operation types.

**Relevant Context:**
- [`SKILL.md` lines 699–715](.bob/skills/research-assistant/SKILL.md) — Other Commands and Critical Distinctions

**Status:** [x] done

---

### 4. Update the Version Control commit prefix table

**Intent:** The `research:` commit prefix currently covers all human-authored work. It needs to be split into `research:` and `project:` so git history clearly reflects which layer changed.

**Expected Outcomes:**
- The commit prefix table has separate `research:` and `project:` rows with distinct descriptions.
- Example commits are updated to show both prefixes in use.

**Todo List:**
1. Split the `research:` row into `research:` (notes/analysis in `research/[topic]/`) and `project:` (brief/content/output in `projects/[name]/`).
2. Add one example commit for each prefix.

**Relevant Context:**
- [`SKILL.md` lines 746–787](.bob/skills/research-assistant/SKILL.md) — Version Control section

**Status:** [x] done

---

### 5. Update `guides/project-initialization.md`

**Intent:** This guide currently describes a single project model with a complex structure (subdirectories, output/, sources/ inside the project). It needs to be rewritten to describe both the research and project types with their correct structures, initialization flows, and starter files.

**Expected Outcomes:**
- Guide has two top-level sections: Research Topics and Projects.
- Research section: describes organic growth, goals.md as the only starter file, no restrictions.
- Project section: describes flat structure, brief.md as the only starter file, no subdirectories.
- Initialization commands match the updated SKILL.md.
- Old commands that create subdirectories inside project folders are removed.

**Todo List:**
1. Replace the Overview section to frame the two-type model.
2. Rewrite the Quick Start section with separate "start a research topic" and "start a project" flows.
3. Rewrite the Project Structure section to show both layouts (research = organic, project = flat).
4. Remove or update any bash commands that create subdirectories inside project folders.
5. Update best practices to reflect the two-type model.

**Relevant Context:**
- [`guides/project-initialization.md`](.bob/skills/research-assistant/guides/project-initialization.md)
- Updated SKILL.md structure block from sub-task 1

**Status:** [x] done

---

### 6. Update `scripts/init-research-project.sh` and add `init-project.sh`

**Intent:** The existing init script creates a complex folder tree with subdirectories inside the project folder — contradicting the flat project rule. It needs to be simplified for research topics and a new flat script created for projects.

**Expected Outcomes:**
- `init-research-project.sh` creates `research/[topic]/goals.md` only and prompts for topic/goals content. No subdirectories.
- New `init-project.sh` creates `projects/[name]/brief.md` only.
- Both scripts have matching output messages that reflect the two-type model.

**Todo List:**
1. Rewrite `init-research-project.sh` to create only `research/[topic]/goals.md` with a goals template (topic, objectives, key questions, decisions this informs, scope).
2. Create `scripts/init-project.sh` that creates only `projects/[name]/brief.md` with a brief template (deliverable, audience, source materials, deadline/context).
3. Update `scripts/README.md` to document both scripts.

**Relevant Context:**
- [`scripts/init-research-project.sh`](.bob/skills/research-assistant/scripts/init-research-project.sh)
- [`scripts/README.md`](.bob/skills/research-assistant/scripts/README.md)

**Status:** [x] done

---

### 7. Update examples and README

**Intent:** Several examples and the skill README reference the old single-project model. They need to reflect the two-type split so they serve as accurate reference material.

**Expected Outcomes:**
- `examples/folder-management/example-1-new-project.md` updated to show both a research topic and a project being created.
- `README.md` updated to describe the three-layer model: wiki (external knowledge), research (internal understanding), projects (deliverables).
- No examples reference subdirectories inside `projects/`.

**Todo List:**
1. Update `examples/folder-management/example-1-new-project.md` to demonstrate both types.
2. Update `README.md` intro and structure description to reflect the three-layer model.
3. Scan remaining examples for any `research/` references that imply the old flat-three-files model and update them.

**Relevant Context:**
- [`examples/folder-management/example-1-new-project.md`](.bob/skills/research-assistant/examples/folder-management/example-1-new-project.md)
- [`README.md`](.bob/skills/research-assistant/README.md)
- [`examples/user-interaction/example-complete-workflow.md`](.bob/skills/research-assistant/examples/user-interaction/example-complete-workflow.md)

**Status:** [x] done
