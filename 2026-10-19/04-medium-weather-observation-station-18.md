# Weather Observation Station 18

| Field      | Value |
|------------|-------|
| Date       | 2026-10-19 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-18/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Take two points: P1 = (min `LAT_N`, min `LONG_W`) and P2 = (max `LAT_N`, max `LONG_W`). Find the Manhattan distance between them, rounded to 4 decimal places.

## Intuition

The Manhattan distance between (a, b) and (c, d) is `|a - c| + |b - d|`. Because P2 uses the maxima and P1 uses the minima, each difference is already zero or positive, so no `ABS` is needed. The formula becomes `(max LAT_N - min LAT_N) + (max LONG_W - min LONG_W)`.

## Solution walkthrough

1. `MAX(LAT_N) - MIN(LAT_N)` is the north–south distance between the two points.
2. `MAX(LONG_W) - MIN(LONG_W)` is the east–west distance.
3. Adding them gives the Manhattan distance.
4. `ROUND(..., 4)` rounds the result to 4 decimal places.

## SQL

```sql
SELECT ROUND(MAX(LAT_N) - MIN(LAT_N) +
 MAX(LONG_W) - MIN(LONG_W), 4) FROM STATION
```
