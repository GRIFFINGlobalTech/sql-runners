# African Cities

| Field      | Value |
|------------|-------|
| Date       | 2026-10-15 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/african-cities/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Given the `CITY` and `COUNTRY` tables, print the names of all cities whose country's `CONTINENT` is `'Africa'`.

`CITY.CountryCode` and `COUNTRY.Code` are the matching key columns.

## Intuition

The city name is in `CITY`, but the continent is in `COUNTRY`. To filter cities by continent, each city row needs its country row next to it, so the two tables are joined on the country code, and then only the African rows are kept.

## Solution walkthrough

1. `FROM CITY INNER JOIN COUNTRY` puts each city next to its country.
2. `ON CITY.CountryCode = COUNTRY.Code` matches a city to the country it belongs to.
3. `WHERE COUNTRY.CONTINENT = 'Africa'` keeps only the African cities.
4. `SELECT CITY.NAME` returns just the city name.

## SQL

```sql
SELECT CITY.NAME 
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode  = COUNTRY.Code 
WHERE COUNTRY.CONTINENT= 'Africa';
```

## Notes

An `INNER JOIN` drops any city whose `CountryCode` has no match in `COUNTRY`. That is fine here, because a city with no country can't be in Africa anyway.

Both tables have a `NAME` column, so `CITY.NAME` must be qualified with its table name. A bare `NAME` would fail with an "ambiguous column" error.
