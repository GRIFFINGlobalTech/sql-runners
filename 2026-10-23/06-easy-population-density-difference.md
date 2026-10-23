# Population Density Difference

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/population-density-difference/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `CITY`, find the difference between the largest and the smallest `POPULATION`.

## Intuition

You can do maths between aggregates directly in the `SELECT`.

## Solution walkthrough

1. `MAX(POPULATION)` finds the biggest population.
2. `MIN(POPULATION)` finds the smallest.
3. Subtracting one from the other gives a single number.

## SQL

```sql
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY
```

## Notes

The query has no `WHERE` because the question covers every city.
