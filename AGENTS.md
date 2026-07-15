# Repository rules

## Project goal

Maintain a reusable Codex Skill for creating independent pinyin-named GitHub repositories and preserving long-running project state across sessions, accounts, devices, models, and agents.

## Repository map

- Skill package: `.codex/skills/xiangmu-chixu-guanli/`
- Core workflow: `.codex/skills/xiangmu-chixu-guanli/SKILL.md`
- Detailed procedures: `.codex/skills/xiangmu-chixu-guanli/references/`
- Output templates: `.codex/skills/xiangmu-chixu-guanli/assets/`
- Validation: `.codex/skills/xiangmu-chixu-guanli/scripts/`
- Project state: `PROJECT_MEMORY.md`, `PLANS.md`, and `CHANGELOG.md`

## Before changing anything

1. Read `README.md`, `PROJECT_MEMORY.md`, `PLANS.md`, and `CHANGELOG.md`.
2. Inspect `git status --short --branch` and preserve unrelated user changes.
3. Read the complete Skill Creator instructions before changing the Skill structure.

## Validation commands

```powershell
$env:PYTHONUTF8='1'
python "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py" '.\.codex\skills\xiangmu-chixu-guanli'
powershell -File '.\.codex\skills\xiangmu-chixu-guanli\scripts\validate-project-continuity.ps1' -SkillRoot '.\.codex\skills\xiangmu-chixu-guanli'
```

There is no build step or formatter configured.

## Long-lived rules

- Keep YAML frontmatter limited to `name` and `description`.
- Keep `SKILL.md` concise and use one-level references for detailed procedures.
- Keep templates in `assets/`; do not duplicate full templates in `SKILL.md`.
- Creation mode must never nest a new project inside an existing Git repository.
- Do not claim remote creation, push, tests, or installation succeeded without verification.
- Do not commit credentials, tokens, local Codex state, logs, caches, or user data.
- Do not force-push, rewrite shared history, or overwrite an existing repository.
- Do not create a license unless the user explicitly chooses one.

## Completion standard

- Official Skill validation passes.
- Custom package validation passes.
- Changed scripts parse and run successfully.
- `README.md`, project memory, plans, and changelog reflect actual state.
- The handoff identifies the current branch, validation result, remote status, and next action.

## Handoff

Before ending a modifying session, update the project state documents and report the real Git and GitHub status. A new Agent must first read `AGENTS.md`, `PROJECT_MEMORY.md`, `PLANS.md`, `CHANGELOG.md`, and `README.md`.
