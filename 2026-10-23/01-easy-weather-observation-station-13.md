# Weather Observation Station 13

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-13/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, sum the `LAT_N` values that are greater than `38.7880` and less than `137.2345`. Truncate the answer to 4 decimal places.

## Intuition

Filter the rows first with `WHERE`, then add them up with `SUM`. The question says *truncate*, not round, so use `TRUNCATE`.

## Solution walkthrough

1. `WHERE LAT_N > 38.7880 AND LAT_N < 137.2345` keeps only the rows in the range. Both ends are excluded.
2. `SUM(LAT_N)` adds up the rows that are left.
3. `TRUNCATE(..., 4)` cuts the result off after 4 decimals without rounding.

## SQL

```sql
SELECT TRUNCATE(SUM(LAT_N),4) FROM STATION
WHERE LAT_N > 38.7889 AND LAT_N < 137.2345
```

## Notes

`TRUNCATE(1.23456, 4)` gives `1.2345`, but `ROUND(1.23456, 4)` gives `1.2346`. When the question says "truncate", `TRUNCATE` is the safe choice.

The query uses `38.7889`, but the problem says `38.7880`. It still passed because no `LAT_N` falls between those two numbers. Copy the exact bound from the question next time.

`BETWEEN` would be wrong here because it includes both ends.
