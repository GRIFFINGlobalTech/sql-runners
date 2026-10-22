# Weather Observation Station 4

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-4/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Find the difference between the total number of `CITY` entries in `STATION` and the number of distinct `CITY` entries.

## Intuition

`COUNT(CITY)` counts every row with a city. `COUNT(DISTINCT CITY)` counts each name only once. Subtracting one from the other gives the number of duplicate entries.

## Solution walkthrough

1. `COUNT(CITY)` returns the total number of city entries.
2. `COUNT(DISTINCT CITY)` returns the number of unique city names.
3. Subtracting the second from the first gives the answer in one row.

## SQL

```sql
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION
```

## Notes

`COUNT(CITY)` skips `NULL`s, but `COUNT(*)` counts them. The two only differ if `CITY` contains `NULL`s, and this table has none.
