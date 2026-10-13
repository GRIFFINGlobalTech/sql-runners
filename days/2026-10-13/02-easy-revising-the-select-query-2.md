# Revising the Select Query II

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/revising-the-select-query-2/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Query only the **`NAME`** field for every American city in the `CITY` table with a population larger than `120000`. The `CountryCode` for America is `USA`.

`CITY(ID, NAME, COUNTRYCODE, DISTRICT, POPULATION)`

## Intuition

This is the same filter as Select Query I, with two changes:
- the threshold goes up to 120,000
- it returns a single column, so name `NAME` instead of using `*`

The lesson is the **projection**: the `SELECT` list controls which columns come back, while `WHERE` controls which rows come back.

## Solution walkthrough

1. `SELECT NAME` returns only the city name column.
2. `WHERE POPULATION > 120000` keeps cities above the threshold.
3. `AND CountryCode = 'USA'` keeps only the American ones.

## SQL

```sql
SELECT NAME
FROM CITY
WHERE POPULATION > 120000
  AND CountryCode = 'USA';
```
