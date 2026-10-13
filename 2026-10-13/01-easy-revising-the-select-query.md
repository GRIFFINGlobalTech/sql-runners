# Revising the Select Query I

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/revising-the-select-query/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Query **all columns** for every American city in the `CITY` table with a population larger than `100000`. The `CountryCode` for America is `USA`.

`CITY(ID, NAME, COUNTRYCODE, DISTRICT, POPULATION)`

## Intuition

This is a plain filter with two conditions that must both be true:
- the population is over 100,000
- the country is the USA

"All columns" means `SELECT *`. Joining the two conditions with `AND` keeps only the rows where both hold.

## Solution walkthrough

1. `SELECT *` returns every column of the table.
2. `FROM CITY` sets the table.
3. `WHERE POPULATION > 100000` drops the smaller cities. Note that `>` is strict, so a city of exactly 100000 is left out.
4. `AND CountryCode = 'USA'` keeps only American cities. The text value goes in single quotes.

## SQL

```sql
SELECT *
FROM CITY
WHERE POPULATION > 100000
  AND CountryCode = 'USA';
```
