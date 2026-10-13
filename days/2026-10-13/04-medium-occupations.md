# Occupations

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/occupations/problem) |
| Dialect    | MySQL (8.0+) |
| Status     | Pending |

## Problem

Pivot `OCCUPATIONS` so there are four columns, Doctor, Professor, Singer and Actor. Each column lists the names in that occupation in alphabetical order, and an empty cell is `NULL`.

## Intuition

A pivot needs a row key that the columns share. There isn't one, so build it: give each person a row number **within their occupation** (1, 2, 3...). The 1st doctor, the 1st professor and so on then all land on row 1.

Then group by that row number and use `MAX(CASE WHEN ...)` to pull each occupation's name into its own column. `MAX` is only there because `GROUP BY` needs an aggregate, and each group has at most one name per occupation.

## Solution walkthrough

1. The inner query uses `ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name)`, so numbering restarts at 1 for each occupation, in alphabetical order.
2. The outer query uses `GROUP BY rn` to get one output row per position.
3. `MAX(CASE WHEN Occupation = 'Doctor' THEN Name END)` returns the doctor at that position, or `NULL` if there is none.
4. `ORDER BY rn` keeps the rows in order.

## SQL

```sql
SELECT
    MAX(CASE WHEN Occupation = 'Doctor'    THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer'    THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor'     THEN Name END) AS Actor
FROM (
    SELECT Name,
           Occupation,
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) t
GROUP BY rn
ORDER BY rn;
```
