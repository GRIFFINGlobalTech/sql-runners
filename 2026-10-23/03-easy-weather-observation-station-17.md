# Weather Observation Station 17

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-17/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, find the `LONG_W` of the row that has the smallest `LAT_N` greater than `38.7780`. Round it to 4 decimal places.

## Intuition

`MIN` can tell you the smallest latitude, but it can't return another column from that same row. Instead, filter the rows, sort them by `LAT_N`, and keep only the first one.

## Solution walkthrough

1. `WHERE LAT_N > 38.7780` keeps only the rows above the limit.
2. `ORDER BY LAT_N ASC` puts the smallest latitude first.
3. `LIMIT 1` keeps only that row.
4. `ROUND(LONG_W, 4)` returns that row's longitude.

## SQL

```sql
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N > 38.7780
ORDER BY LAT_N ASC
LIMIT 1;
```

## Notes

The same answer with a subquery:
`SELECT ROUND(LONG_W, 4) FROM STATION WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780);`

Station 15 uses the same pattern in the other direction: `<` with `ORDER BY ... DESC`.
