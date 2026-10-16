# Average Population of Each Continent

| Field      | Value |
|------------|-------|
| Date       | 2026-10-16 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/average-population-of-each-continent/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Using the `CITY` and `COUNTRY` tables, list every continent with the average population of its cities, rounded down to the nearest whole number.

## Intuition

The population is in `CITY`, but the continent is in `COUNTRY`, so the two tables have to be joined. They share a key: `CITY.CountryCode` matches `COUNTRY.Code`. After the join, group by continent and average the population. "Rounded down" means `FLOOR`, not `ROUND`.

## Solution walkthrough

1. `INNER JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code` attaches each city to its country, so each row knows its continent. Cities without a matching country are dropped, which is what the question wants.
2. `GROUP BY COUNTRY.Continent` makes one group per continent.
3. `AVG(CITY.Population)` averages the city populations in each group.
4. `FLOOR(...)` rounds that average down to a whole number.

## SQL

```sql
SELECT 
    COUNTRY.Continent, 
    FLOOR(AVG(CITY.Population)) AS Average_City_Population
FROM CITY
INNER JOIN COUNTRY 
    ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;
```

## Notes

`ROUND` would fail on some continents, because it rounds 0.5 and above up. The question asks for the value rounded down, which is `FLOOR`.
