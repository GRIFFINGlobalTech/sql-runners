# Weather Observation Station 9

| Field      | Value |
|------------|-------|
| Date       | 2026-10-28 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-9/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From the `STATION` table, list the `CITY` names that do **not** start with a vowel (a, e, i, o, u). The result must not contain duplicates.

## Intuition

This is the opposite of Weather Observation Station 6 (cities that *do* start with a vowel). There, the conditions are joined with `OR`, since any one vowel is enough. Here, a city has to fail all five checks, so the `NOT LIKE` conditions are joined with `AND`.

## Solution walkthrough

1. `SELECT DISTINCT CITY` removes repeated city names.
2. `CITY NOT LIKE 'A%'` means "does not start with A". `%` matches anything after the first letter.
3. The five `NOT LIKE` conditions are joined with `AND`, so a city is kept only if it starts with none of the vowels.

## SQL

```sql
SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT LIKE 'A%' 
  AND CITY NOT LIKE 'E%' 
  AND CITY NOT LIKE 'I%' 
  AND CITY NOT LIKE 'O%' 
  AND CITY NOT LIKE 'U%';
```

## Notes

Using `OR` between `NOT LIKE`s is a common mistake. Every city fails at least one of the checks (a city can't start with both A and E), so `OR` would return every city.

A shorter version uses a regex: `WHERE CITY NOT REGEXP '^[aeiou]'`. MySQL's default collation is case-insensitive, so `LIKE 'a%'` and `LIKE 'A%'` match the same rows.
