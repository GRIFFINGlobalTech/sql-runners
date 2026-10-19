# Weather Observation Station 15

| Field      | Value |
|------------|-------|
| Date       | 2026-10-19 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-15/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Find the `LONG_W` of the row with the largest `LAT_N` that is less than 137.2345, rounded to 4 decimal places.

## Intuition

This builds on Station 14. Station 14 finds the latitude itself. Here we need a different column (`LONG_W`) from the row that has that latitude. There are two ways to do it:

- Find the latitude with a subquery, then pick the row whose `LAT_N` equals it.
- Sort the rows below the limit by `LAT_N` from largest to smallest and take the first one.

## Solution walkthrough

Using the `ORDER BY` version below:

1. `WHERE LAT_N < 137.2345` keeps only the rows below the limit.
2. `ORDER BY LAT_N DESC` puts the largest latitude first.
3. `LIMIT 1` keeps only that row.
4. `ROUND(LONG_W, 4)` returns that row's longitude, rounded to 4 decimal places.

## SQL

```sql
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1;
```

## Notes

The first submission failed:

```sql
SELECT ROUND(LONG_W, 4) 
FROM STATION 
WHERE LAT_N = (
    SELECT MAX(LAT_N) 
    FROM STATION 
    WHERE LAT_N < 137.2345
);
```

The logic was right. The usual reasons this query fails:

- **Dialect:** make sure the HackerRank editor is set to **MySQL**. Other dialects can handle this query differently.
- **Exact floating-point comparison:** `LAT_N = (subquery)` only matches when the stored value and the `MAX` value are exactly equal. With floating-point columns this can fail and return no rows. The `ORDER BY ... LIMIT 1` version above never compares two values for equality, so it avoids this problem.
