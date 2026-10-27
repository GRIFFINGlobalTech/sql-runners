# Draw The Triangle 1

| Field      | Value |
|------------|-------|
| Date       | 2026-10-27 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/draw-the-triangle-1/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Print the pattern P(20): 20 rows of stars, starting with 20 `* ` on the first row and dropping one star per row down to a single `*`.

## Intuition

There is no table with the data, so the query needs some table with at least 20 rows just to produce 20 output rows. `information_schema.tables` always has plenty. A user variable acts as a counter that goes down by one on every row, and `REPEAT('* ', n)` builds the row.

## Solution walkthrough

1. `SET @stars = 21;` starts the counter one above the first row's count.
2. For each row read from `information_schema.tables`, `@stars := @stars - 1` decrements the counter and returns the new value (20, 19, 18 ...).
3. `REPEAT('* ', @stars)` prints that many stars.
4. `LIMIT 20` stops after 20 rows, so the last row has 1 star.

## SQL

```sql
SET @stars = 21;

SELECT REPEAT('* ', @stars := @stars - 1) 
FROM information_schema.tables 
LIMIT 20;
```

## Notes

The rows in `information_schema.tables` are only used as a row generator; their content is ignored. On MySQL 8 a recursive CTE (`WITH RECURSIVE n AS (SELECT 20 ... UNION ALL SELECT x - 1 ...)`) does the same without relying on variable assignment inside a `SELECT`, which is deprecated.
