# Weather Observation Station 6

| Field      | Value |
|------------|-------|
| Date       | 2026-10-16 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-6/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names that start with a vowel (a, e, i, o or u). The result can contain duplicates.

## Intuition

"Starts with X" is a `LIKE 'X%'` pattern. There are five vowels, so there are five patterns, joined with `OR`. MySQL's default collation ignores case, so `'a%'` also matches cities that start with a capital `A`.

## Solution walkthrough

1. `SELECT CITY FROM STATION` reads every city.
2. Each `CITY LIKE '<vowel>%'` keeps names whose first character is that vowel. The `%` matches whatever follows.
3. The five conditions are joined with `OR`, so a city is kept if it matches any one of them.

## SQL

```sql
SELECT  CITY FROM STATION 
WHERE CITY LIKE 'a%'
           OR CITY LIKE 'e%'
           OR CITY LIKE 'i%'
           OR CITY LIKE 'o%'
           OR CITY LIKE 'u%';
```

## Notes

Every `OR` needs its own complete condition. Writing `OR LIKE 'u%'` without the column name is a syntax error, because `LIKE` needs something on its left to compare.

A shorter version that does the same thing:

```sql
SELECT CITY FROM STATION WHERE LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');
```
