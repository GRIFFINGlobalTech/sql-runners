# Japanese Cities' Names

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/japanese-cities-name/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `CITY`, list the `NAME` of every Japanese city. The `COUNTRYCODE` for Japan is `JPN`.

## Intuition

Select one column and filter by country code.

## Solution walkthrough

1. `SELECT NAME` returns only the name column.
2. `WHERE COUNTRYCODE = 'JPN'` keeps only the Japanese cities.

## SQL

```sql
SELECT NAME FROM CITY 
WHERE COUNTRYCODE = 'JPN';
```

## Notes

Japanese Cities' Attributes uses the same filter with `SELECT *`.
