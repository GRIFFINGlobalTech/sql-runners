# Japan Population

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/japan-population/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `CITY`, find the total population of all Japanese cities (`COUNTRYCODE = 'JPN'`).

## Intuition

Filter the rows with `WHERE`, then add them up with `SUM`.

## Solution walkthrough

1. `WHERE COUNTRYCODE = 'JPN'` keeps only the Japanese cities.
2. `SUM(POPULATION)` adds up their populations.

## SQL

```sql
SELECT SUM(POPULATION)FROM CITY 
WHERE COUNTRYCODE = 'JPN'
```

## Notes

`SUM(POPULATION)FROM` with no space still runs because the closing `)` ends the token. Adding a space makes it easier to read.
