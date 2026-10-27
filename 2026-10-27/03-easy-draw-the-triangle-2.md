# Draw The Triangle 2

| Field      | Value |
|------------|-------|
| Date       | 2026-10-27 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/draw-the-triangle-2/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Print the pattern P(20) the other way up: 20 rows, starting with one `*` and adding one star per row up to 20.

## Intuition

Same trick as [Draw The Triangle 1](02-easy-draw-the-triangle-1.md), but the counter starts at 0 and counts up.

## Solution walkthrough

1. `SET @stars = 0;` starts the counter at zero.
2. `@stars := @stars + 1` increments it on every row (1, 2, 3 ...).
3. `REPEAT('* ', @stars)` prints that many stars.
4. `LIMIT 20` stops at the row with 20 stars.

## SQL

```sql
SET @stars = 0;

SELECT REPEAT('* ', @stars := @stars + 1) 
FROM information_schema.tables 
LIMIT 20;
```

## Notes

The only difference from Triangle 1 is the start value (0 instead of 21) and `+ 1` instead of `- 1`.
