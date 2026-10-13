# The PADS

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/the-pads/problem) |
| Dialect    | MySQL |
| Status     | [ ] Not solved |

## Problem

Write two queries on `OCCUPATIONS(Name, Occupation)`:
1. Every name followed by the first letter of the occupation in brackets, for example `Ashely(P)`, sorted by name.
2. One line per occupation: `There are a total of N doctors.`, sorted by the count and then by occupation name.

## Intuition

These are two independent queries, and HackerRank accepts both in one submission.
- Query 1 builds a string with `CONCAT` and `LEFT(Occupation, 1)`.
- Query 2 uses `GROUP BY Occupation` with `COUNT(*)`, and `LOWER()` turns "Doctor" into "doctor" so the sentence reads correctly.

## Solution walkthrough

1. `CONCAT(Name, '(', LEFT(Occupation, 1), ')')` gives `Name(X)`.
2. The `GROUP BY` collapses the rows to one per occupation, and `COUNT(*)` gives N.
3. `ORDER BY COUNT(*), Occupation` sorts by the smallest count first and breaks ties alphabetically.

## SQL

```sql
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
```
