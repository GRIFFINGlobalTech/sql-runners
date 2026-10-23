# Weather Observation Station 16

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-16/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, find the smallest `LAT_N` that is greater than `38.7780`. Round it to 4 decimal places.

## Intuition

"Smallest value above a limit" means filtering with `WHERE` and then taking `MIN`.

## Solution walkthrough

1. `WHERE LAT_N > 38.7780` drops everything at or below the limit.
2. `MIN(LAT_N)` picks the smallest value that's left.
3. `ROUND(..., 4)` formats the answer.

## SQL

```sql
SELECT ROUND(MIN(LAT_N), 4) FROM 
STATION WHERE LAT_N > 38.7780
```

## Notes

This is the opposite of Station 14, which wants the largest value below a limit (`MAX` with `<`).
