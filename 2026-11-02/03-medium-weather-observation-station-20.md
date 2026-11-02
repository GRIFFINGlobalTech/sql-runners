# Weather Observation Station 20

| Field      | Value |
|------------|-------|
| Date       | 2026-11-02 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-20/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Find the **median** of the `LAT_N` column in the `STATION` table and round it to 4 decimal places.

## Intuition

The median is the middle value. As many values sit below it as above it. MySQL has no `MEDIAN()` function, so the query has to find that row itself. For each row, count how many latitudes are smaller and how many are larger. The row where the two counts are equal is the median.

## Solution walkthrough

1. The outer query looks at each row `S` in `STATION`.
2. The first subquery counts the rows with a `LAT_N` smaller than `S.LAT_N`.
3. The second subquery counts the rows with a `LAT_N` larger than `S.LAT_N`.
4. `WHERE` keeps only the row where the two counts match, which is the middle row.
5. `ROUND(S.LAT_N, 4)` formats the answer to 4 decimal places.

## SQL

```sql
SELECT ROUND(S.LAT_N, 4)
FROM STATION S
WHERE (SELECT COUNT(*) FROM STATION WHERE LAT_N < S.LAT_N)
    = (SELECT COUNT(*) FROM STATION WHERE LAT_N > S.LAT_N);
```

## Notes

This works because HackerRank's `STATION` table has an odd number of rows and no duplicate `LAT_N` values, so exactly one row is in the middle. With an even row count no row would match, and the median would be the average of the two middle values.

These are correlated subqueries: both counts run again for every row, so the query is O(n²). That's fine for this table, but on a big table a `ROW_NUMBER()` window function scales better:

```sql
SELECT ROUND(AVG(LAT_N), 4)
FROM (
    SELECT LAT_N,
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS rn,
           COUNT(*) OVER () AS cnt
    FROM STATION
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2));
```
