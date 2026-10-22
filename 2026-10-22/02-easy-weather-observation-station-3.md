# Weather Observation Station 3

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-3/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `STATION`, list the `CITY` names for stations with an even `ID`. Don't repeat a city name.

## Intuition

A number is even when dividing it by 2 leaves no remainder, which is `ID % 2 = 0`. "Don't repeat" means `DISTINCT`.

## Solution walkthrough

1. `WHERE ID % 2 = 0` keeps the stations with an even ID.
2. `SELECT DISTINCT CITY` returns each remaining city name once.

## SQL

```sql
SELECT DISTINCT(CITY) FROM STATION
WHERE ID % 2 = 0
```

## Notes

`DISTINCT` is a keyword, not a function, so the brackets in `DISTINCT(CITY)` are optional. `SELECT DISTINCT CITY` does the same thing. `MOD(ID, 2) = 0` also works in place of `%`.
