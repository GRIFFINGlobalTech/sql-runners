# Weather Observation Station 5

| Field      | Value |
|------------|-------|
| Date       | 2026-10-15 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-5/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, print the city with the shortest name and the city with the longest name, each with its name length. If more than one city ties for shortest or longest, pick the one that comes first alphabetically.

## Intuition

These are two separate questions with one answer each, so it is easiest to write two small queries and stack the results:

- Shortest: sort by length ascending and take the first row.
- Longest: sort by length descending and take the first row.

The tie-break is a second sort key, `CITY ASC`, in both queries.

## Solution walkthrough

1. The first query sorts by `LENGTH(CITY) ASC, CITY ASC` and keeps one row with `LIMIT 1`. That row is the shortest name, and the alphabetically first one if there is a tie.
2. The second query sorts by `LENGTH(CITY) DESC, CITY ASC` and keeps one row. That row is the longest name, again alphabetically first on a tie.
3. `UNION ALL` stacks the two single-row results into the two-line output.

## SQL

```sql
(SELECT  CITY,LENGTH(CITY) FROM STATION 
ORDER BY LENGTH(CITY) ASC ,CITY ASC
LIMIT 1)
UNION ALL
(SELECT  CITY ,LENGTH(CITY) FROM STATION 
ORDER BY LENGTH(CITY) DESC ,CITY ASC
LIMIT 1);
```

## Notes

The parentheses are required. Without them, MySQL applies the `ORDER BY` and `LIMIT` to the whole `UNION` and not to each half, so you would get one row instead of two.

`UNION ALL` is the right choice over `UNION`. `UNION` removes duplicate rows, and it would only matter if the shortest and longest city were the same row, which can't happen when the names have different lengths. `UNION ALL` also skips the de-duplication step.
