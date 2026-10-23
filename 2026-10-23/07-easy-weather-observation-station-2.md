# Weather Observation Station 2

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-2/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, find the sum of all `LAT_N` values and the sum of all `LONG_W` values, each rounded to 2 decimal places. Print both on one line, separated by a space.

## Intuition

Two aggregates in one `SELECT` come back as two columns in a single row. HackerRank prints that row as the two values separated by a space.

## Solution walkthrough

1. `SUM(LAT_N)` adds up every latitude.
2. `SUM(LONG_W)` adds up every longitude.
3. `ROUND(..., 2)` rounds each sum to 2 decimals.

## SQL

```sql
SELECT ROUND(SUM(LAT_N),2), ROUND(SUM(LONG_W ),2)
FROM STATION AS lat
```

## Notes

The table alias `lat` isn't used anywhere, so it can be removed. Aliases matter when a query joins tables or refers to the same table twice.
