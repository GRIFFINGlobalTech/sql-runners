# Weather Observation Station 14

| Field      | Value |
|------------|-------|
| Date       | 2026-10-19 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-14/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Find the largest `LAT_N` in `STATION` that is less than 137.2345, rounded to 4 decimal places.

## Intuition

"Largest value below a limit" means: filter out everything at or above the limit, then take the `MAX` of what remains.

## Solution walkthrough

1. `WHERE LAT_N < 137.2345` keeps only the latitudes below the limit.
2. `MAX(LAT_N)` picks the largest of those.
3. `ROUND(..., 4)` rounds it to 4 decimal places.

## SQL

```sql
SELECT ROUND(MAX(LAT_N), 4) 
FROM STATION 
WHERE LAT_N < 137.2345;
```
