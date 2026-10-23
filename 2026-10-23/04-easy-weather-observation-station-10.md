# Weather Observation Station 10

| Field      | Value |
|------------|-------|
| Date       | 2026-10-23 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-10/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names that do not end with a vowel. The result can't contain duplicates.

## Intuition

`LIKE '%a'` matches names that end in `a`. Adding `NOT` in front, once for each vowel, removes every name that ends in a vowel.

## Solution walkthrough

1. Each `CITY NOT LIKE '%x'` throws out the names that end in that vowel.
2. The `AND`s mean a name has to pass all five checks.
3. `DISTINCT` removes repeated names.

## SQL

```sql
SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT LIKE '%a' 
  AND CITY NOT LIKE '%e' 
  AND CITY NOT LIKE '%i' 
  AND CITY NOT LIKE '%o' 
  AND CITY NOT LIKE '%u';
```

## Notes

A shorter version: `WHERE LOWER(RIGHT(CITY, 1)) NOT IN ('a','e','i','o','u')`. This is the same check used in Station 12 (Day 7).
