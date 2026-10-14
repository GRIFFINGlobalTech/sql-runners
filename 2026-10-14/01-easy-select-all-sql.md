# Select All

| Field      | Value |
|------------|-------|
| Date       | 2026-10-14 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/select-all-sql/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Query all columns (attributes) for every row in the `CITY` table.

`CITY(ID, NAME, COUNTRYCODE, DISTRICT, POPULATION)`

## Intuition

No filter, no sorting, no joins. "All columns" plus "every row" is just `SELECT *` on the table.

## Solution walkthrough

1. `SELECT *` returns every column.
2. `FROM CITY` sets the table.
3. There is no `WHERE`, so every row comes back.

## SQL

```sql
SELECT * FROM CITY;
```
