# Asian Population

| Field      | Value |
|------------|-------|
| Date       | 2026-10-27 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/asian-population/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Given `CITY` and `COUNTRY`, find the total population of all cities whose continent is `Asia`. `CITY.CountryCode` matches `COUNTRY.Code`.

## Intuition

The continent lives in `COUNTRY`, the population in `CITY`. Join them on the country code so each city row knows its continent, filter to Asia, then sum.

## Solution walkthrough

1. `JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code` attaches each city's country row.
2. `WHERE COUNTRY.CONTINENT = 'Asia'` keeps only Asian cities.
3. `SUM(CITY.POPULATION)` adds up their populations.

## SQL

```sql
SELECT SUM(CITY.POPULATION)
FROM CITY
JOIN COUNTRY 
  ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.CONTINENT = 'Asia';
```

## Notes

`COUNTRY` also has its own `POPULATION` column, so prefixing it as `CITY.POPULATION` matters here; a bare `POPULATION` would be ambiguous and error out.
