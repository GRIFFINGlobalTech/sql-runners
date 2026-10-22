# Weather Observation Station 7

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-7/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names that end with a vowel (a, e, i, o or u). The result can't contain duplicates.

## Intuition

This is Station 6 reversed. "Starts with" was `'a%'`; "ends with" moves the `%` to the front: `'%a'`. No duplicates means `DISTINCT`.

## Solution walkthrough

1. Each `CITY LIKE '%<vowel>'` keeps names whose last character is that vowel. The `%` matches whatever comes before it.
2. The five conditions are joined with `OR`, so a city is kept if it matches any one of them.
3. `DISTINCT` removes repeated names.

## SQL

```sql
SELECT DISTINCT CITY FROM STATION
WHERE 
  CITY LIKE '%a' OR
  CITY  LIKE '%e' OR
 CITY LIKE '%i' OR
 CITY LIKE '%o' OR
 CITY LIKE '%u';
```

## Notes

A shorter version that does the same thing:

```sql
SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');
```
