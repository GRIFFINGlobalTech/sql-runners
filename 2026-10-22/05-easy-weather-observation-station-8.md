# Weather Observation Station 8

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-8/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names that both start and end with a vowel. The result can't contain duplicates.

## Intuition

This combines Station 6 (starts with a vowel) and Station 7 (ends with a vowel). Both must be true, so the two groups are joined with `AND`.

## Solution walkthrough

1. The first bracket keeps cities that start with a vowel (`'a%'` ... `'u%'`).
2. The second bracket keeps cities that end with a vowel (`'%a'` ... `'%u'`).
3. `AND` between the brackets means a city must pass both.
4. `DISTINCT` removes repeated names.

## SQL

```sql
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%')
  AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');
```

## Notes

The brackets matter. SQL evaluates `AND` before `OR`, so without them the query would read as `... OR (CITY LIKE 'u%' AND CITY LIKE '%a') OR ...` and return cities that only start with a vowel.

A shorter version that does the same thing:

```sql
SELECT DISTINCT CITY FROM STATION
WHERE LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u')
  AND RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');
```
