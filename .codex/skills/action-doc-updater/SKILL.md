---
name: action-doc-updater
description: Systematically update project docs and logs after successful tasks or significant code/requirement changes. Use when finishing work that should be reflected in progress logs, changelogs/release notes, READMEs/how-tos, API specs, requirements/ADR notes, or inline comments.
---

# Action Doc Updater

## Overview

Keep documentation current after meaningful changes. Apply this workflow before closing a task so future maintainers see accurate outcomes, decisions, and how to reproduce or verify them.

## Quick start

- Identify what changed and why it matters.
- List the documentation touchpoints affected (progress logs, requirements, API/README, changelog, tests notes).
- Draft concise updates using the templates below.
- Validate that docs match the latest code/config and that commands/links work.

## Workflow

### 1) Qualify and gather facts
- Capture the outcome: what was done, why, and the resulting behavior.
- Note verification: tests/commands run and their results.
- Record scope: code/test/config/requirements changes and known follow-ups.

### 2) Choose targets to update
- Progress/iteration logs (e.g., `progress.txt`): add a dated bullet with outcome, tests, and next steps.
- Requirements/PRD/ADR: revise decisions, acceptance criteria, and status; capture requirement deltas.
- README/How-to: adjust setup/usage commands, env vars, endpoints, examples, and caveats.
- API docs/specs: sync endpoint descriptions, request/response bodies, error cases, and auth notes; update OpenAPI/docstrings if present.
- Changelog/release notes: summarize user-facing impact and migration steps (or note none).
- Code comments/config samples: refresh if behavior, defaults, or parameters changed.
- Test documentation: mention new/updated tests and remaining gaps or manual checks.

### 3) Write updates
- Be specific: what changed, why, impact, and where to look.
- Use active voice and short sentences; mirror existing formatting.
- Cross-link canonical files/sections instead of duplicating long content.
- Call out follow-ups or known limitations so they are not forgotten.

### 4) Verify accuracy
- Re-read docs against the latest code/config; remove stale statements.
- Smoke-check commands/endpoints you document where feasible.
- Ensure links and file references resolve; keep terminology consistent.

## Templates

- Progress log bullet: `- YYYY-MM-DD: <action/result>. Impact: <behavior/users>. Tests: <cmd>/<result>. Next: <follow-up or N/A>.`
- Changelog entry: `- <Area>: <concise change>. Impact: <user/ops effect>. Migration: <steps or none>.`
- Requirements note: `Decision: <what/why>. Affects: <modules/users>. Status: <planned/in-progress/done>. Open questions: <if any>.`
- API note: `Endpoint <verb> <path>: <behavior change>. Request: <fields>. Response: <fields/status>. Errors: <cases>.`

## Reference scanning

- Scan the repo for canonical docs before editing (`progress.txt`, `prd.json`, `README*`, `docs/`, `ADR*`, `CHANGELOG*`, `docs/api*`, config samples). Update the single source of truth, then mirror where needed.
- If no obvious doc exists, note the decision in the nearest project log and create a minimal section rather than leaving it undocumented.

## Resources (optional)

- `references/`: Reserve for checklists or examples if the base instructions need expansion. Add files only when new material is required and link them here.
