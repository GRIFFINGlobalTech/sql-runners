# Weather Observation Station 12

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-12/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names that do not start with a vowel and do not end with a vowel. The result can't contain duplicates.

## Intuition

This is Station 8 flipped. Instead of ten `NOT LIKE`s, take the first character with `LEFT(CITY, 1)` and the last with `RIGHT(CITY, 1)`, and check that neither is `IN` the vowel list.

## Solution walkthrough

1. `LEFT(CITY, 1)` gets the first letter, and `NOT IN (...)` keeps it only if it isn't a vowel.
2. `RIGHT(CITY, 1)` does the same for the last letter.
3. `AND` means both ends must be non-vowels.
4. `LOWER` turns capitals into lowercase so `'A'` matches `'a'`.
5. `DISTINCT` removes repeated names.

## SQL

```sql
SELECT DISTINCT CITY 
FROM STATION 
WHERE LOWER(LEFT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u')
  AND LOWER(RIGHT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');
```

## Notes

MySQL's default collation already ignores case, so `LOWER` isn't strictly needed here. It does make the query safe on databases that compare case-sensitively, like PostgreSQL.

Watch the wording: Station 11 is "doesn't start **or** doesn't end with a vowel", which needs `OR` instead of `AND`.
