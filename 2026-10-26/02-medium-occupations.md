# Occupations

| Field      | Value |
|------------|-------|
| Date       | 2026-10-26 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/occupations/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Pivot the `Occupation` column in `OCCUPATIONS(Name, Occupation)` so that each name sits under its occupation, sorted alphabetically. Output four columns in this order: **Doctor, Professor, Singer, Actor**. Print `NULL` when an occupation has no more names.

This is a retake. The first attempt on [2026-10-13](../2026-10-13/04-medium-occupations.md) failed. This time it was solved another way, with MySQL user variables instead of `ROW_NUMBER()`.

## Intuition

To pivot, the four columns need a shared row key. The 1st doctor, 1st professor, 1st singer and 1st actor must land on the same row. So number each name within its own occupation, in alphabetical order.

Here the numbering is done by hand with four counters, `@r1` to `@r4`, one per occupation. Rows are read in name order, and each row bumps only its own occupation's counter. That value becomes `RowLine`. Then `GROUP BY RowLine` and `MIN(...)` pull each occupation's name into its column.

## Solution walkthrough

1. `SET @r1 = 0, ...` resets the four counters before the query runs.
2. The inner query sorts by `Name`. For each row, the first `CASE` increments the counter for that row's occupation and returns the new value as `RowLine` (1, 2, 3 ... per occupation).
3. The other four `CASE` columns put the name in its occupation's column and `NULL` in the rest.
4. The outer query groups by `RowLine`. Row 1 collects the first name of every occupation, row 2 the second, and so on.
5. `MIN()` is only there because `GROUP BY` needs an aggregate. Each (RowLine, occupation) cell holds at most one name, so `MIN` returns that name, or `NULL` if there isn't one.

## SQL

```sql
SET @r1 = 0, @r2 = 0, @r3 = 0, @r4 = 0;

SELECT 
    MIN(Doctor), 
    MIN(Professor), 
    MIN(Singer), 
    MIN(Actor)
FROM (
    SELECT 
        CASE 
            WHEN Occupation = 'Doctor' THEN (@r1 := @r1 + 1)
            WHEN Occupation = 'Professor' THEN (@r2 := @r2 + 1)
            WHEN Occupation = 'Singer' THEN (@r3 := @r3 + 1)
            WHEN Occupation = 'Actor' THEN (@r4 := @r4 + 1)
        END AS RowLine,
        CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
        CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
        CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
        CASE WHEN Occupation = 'Actor' THEN Name END AS Actor
    FROM OCCUPATIONS
    ORDER BY Name
) temp
GROUP BY RowLine;
```

## Notes

This passes on HackerRank, but it relies on MySQL evaluating the variable assignments in `ORDER BY Name` order. MySQL doesn't guarantee that, and MySQL 8 warns that setting variables inside expressions is deprecated. There's also no `ORDER BY RowLine` at the end, so the row order is up to the engine.

The `ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name)` version from Day 1 does the same job with a guaranteed order. Prefer it on MySQL 8+.
