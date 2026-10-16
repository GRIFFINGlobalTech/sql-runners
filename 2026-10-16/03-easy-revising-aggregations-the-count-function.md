# Revising Aggregations - The Count Function

| Field      | Value |
|------------|-------|
| Date       | 2026-10-16 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Count how many cities in `CITY` have a population larger than 100,000.

## Intuition

Filter first, then count. `WHERE` keeps only the large cities, and `COUNT(*)` counts the rows that are left.

## Solution walkthrough

1. `WHERE POPULATION > 100000` keeps cities with more than 100,000 people. "Larger than" means strictly greater, so it is `>` and not `>=`.
2. `COUNT(*)` returns the number of rows that pass the filter, as a single value.

## SQL

```sql
SELECT COUNT(*) FROM CITY 
WHERE POPULATION>100000
```
