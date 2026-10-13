# SQL Runners

Daily HackerRank SQL practice: **6 questions a day — 2 Easy, 2 Medium, 2 Hard.**

## Structure

```
SQLRunners/
├── days/
│   └── 2026-10-13/              one folder per day (also one branch per day)
│       ├── README.md            index for the day
│       ├── 01-easy-<slug>.md
│       ├── 02-easy-<slug>.md
│       ├── 03-medium-<slug>.md
│       ├── 04-medium-<slug>.md
│       ├── 05-hard-<slug>.md
│       └── 06-hard-<slug>.md
├── scripts/new-day.ps1          scaffolds a new day + branch
└── templates/question.md        template every question file starts from
```

Every question file contains: link to the question, difficulty, intuition, solution walkthrough, and the SQL query.

## Daily workflow

```powershell
.\scripts\new-day.ps1                     # creates days/<today>/ and checks out branch <today>
# solve the 6 questions, fill in the .md files, rename them to the real slugs
git add days/<today>
git commit -m "SQL Runner <today>"
git push -u origin <today>
```

## Log

| Date | Branch | Easy | Medium | Hard |
|------|--------|------|--------|------|
| 2026-10-13 | [`2026-10-13`](../../tree/2026-10-13/days/2026-10-13) | Weather Observation Station 5, Higher Than 75 Marks | The PADS, Occupations | Interviews, 15 Days of Learning SQL |
