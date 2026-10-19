# Weather Observation Station 1

| Field      | Value |
|------------|-------|
| Date       | 2026-10-19 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/weather-observation-station-1/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

List the `CITY` and `STATE` of every row in `STATION`.

## Intuition

There is no filter, grouping or sorting. You only pick two columns.

## Solution walkthrough

1. `SELECT CITY, STATE` picks the two columns in the order the question asks for.
2. `FROM STATION` reads every row, and nothing is filtered out.

## SQL

```sql
SELECT CITY,STATE FROM STATION
```
