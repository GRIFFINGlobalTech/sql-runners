# Revising Aggregations - The Average Function

| Field      | Value |
|------------|-------|
| Date       | 2026-10-27 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `CITY`, find the average population of all cities in the `DISTRICT` called `California`.

## Intuition

Filter to the California rows with `WHERE`, then let `AVG` work out the mean.

## Solution walkthrough

1. `WHERE DISTRICT = 'California'` keeps only the California cities.
2. `AVG(POPULATION)` returns the average of their populations.

## SQL

```sql
SELECT AVG(POPULATION) FROM CITY WHERE 
DISTRICT = 'California'
```

## Notes

`AVG` returns a decimal, so the answer can have a fractional part. HackerRank accepts it as is; no rounding is asked for here.
