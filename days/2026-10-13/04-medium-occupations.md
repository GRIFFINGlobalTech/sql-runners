# Occupations

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/occupations/problem) |
| Dialect    | MySQL (8.0+) |
| Status     | Failed |

## Problem

Pivot `OCCUPATIONS(Name, Occupation)` so that each occupation becomes a column, in the order **Doctor, Professor, Singer, Actor**. Each column lists that occupation's names alphabetically, top to bottom. When one column runs out of names, its cells are `NULL`.

## Intuition

A pivot needs a row key that the columns share, and this table doesn't have one. So build it: give each person a row number **within their occupation**, in alphabetical order (1, 2, 3 ...). The 1st doctor, the 1st professor, the 1st singer and the 1st actor then all share `rn = 1` and land on the same output row.

Then `GROUP BY rn` and use `MAX(CASE WHEN Occupation = 'X' THEN Name END)` to pull each occupation's name into its own column. `MAX` is only there because `GROUP BY` needs an aggregate. Each (rn, occupation) pair holds at most one name, so `MAX` simply returns it, or `NULL` when there isn't one.

## Solution walkthrough

1. The inner query uses `ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name)`, so numbering restarts at 1 for each occupation in alphabetical order.
2. The outer query uses `GROUP BY rn`, which gives one output row per position.
3. The four `MAX(CASE ...)` columns are written in the **required order**: Doctor, Professor, Singer, Actor.
4. `ORDER BY rn` keeps the rows top to bottom.

Expected output on the test data:

```
Aamina Ashley Christeen Eve
Julia Belvet Jane Jennifer
Priya Britney Jenny Ketty
NULL Maria Kristeen Samantha
NULL Meera NULL NULL
NULL Naomi NULL NULL
NULL Priyanka NULL NULL
```

## SQL (corrected solution)

```sql
SELECT
    MAX(CASE WHEN Occupation = 'Doctor'    THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer'    THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor'     THEN Name END) AS Actor
FROM (
    SELECT Name, Occupation,
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) AS t
GROUP BY rn
ORDER BY rn;
```

## Notes (if it fails)

> **Correction:** the original submission failed. The query in **SQL (corrected solution)** above is the corrected solution. Status stays **Failed** to keep an honest record of the attempt.

**What the grader showed (original submission):** `Wrong Answer`.

**Checklist, most likely cause first:**

| Check | Why it matters |
|-------|----------------|
| Language dropdown is **MySQL** | The editor keeps a separate draft per language. Under MS SQL Server, Oracle or DB2 you may be submitting a different (old or empty) draft |
| You're on the right problem page | This query on The PADS page (or the PADS query here) runs fine but gives the wrong shape. That's what happened on The PADS today |
| Column order is **Doctor, Professor, Singer, Actor** | The grader compares by position. Alphabetical order (Actor, Doctor ...) is wrong |
| `ORDER BY Name` is **inside** `OVER (...)` | Without it, the row numbers are arbitrary and the names aren't alphabetical down each column |
| `PARTITION BY Occupation` is present | Without it, every row gets a unique number, so you get one name per row and NULLs everywhere else |
| `ORDER BY rn` at the end | Without it, `GROUP BY` doesn't guarantee the row order |

**Fallback without window functions** (works on old MySQL 5.x too). It ranks each name by counting how many names in the same occupation sort at or before it:

```sql
SELECT
    MAX(CASE WHEN Occupation = 'Doctor'    THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer'    THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor'     THEN Name END) AS Actor
FROM (
    SELECT o.Name,
           o.Occupation,
           (SELECT COUNT(*)
            FROM OCCUPATIONS o2
            WHERE o2.Occupation = o.Occupation
              AND o2.Name <= o.Name) AS rn
    FROM OCCUPATIONS o
) t
GROUP BY rn
ORDER BY rn;
```
