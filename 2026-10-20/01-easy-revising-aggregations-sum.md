# Revising Aggregations - The Sum Function

| Field      | Value |
|------------|-------|
| Date       | 2026-10-20 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/revising-aggregations-sum/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Find the total population of all cities in `CITY` whose `DISTRICT` is California.

## Intuition

Filter first, then add up. `WHERE` keeps only the California rows, and `SUM` adds up their populations.

## Solution walkthrough

1. `WHERE DISTRICT = 'California'` keeps only the cities in California.
2. `SUM(POPULATION)` adds up their populations and returns a single number.

## SQL

```sql
SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = 'California'
```
