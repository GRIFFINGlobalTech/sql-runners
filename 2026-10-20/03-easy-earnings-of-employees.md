# Top Earners

| Field      | Value |
|------------|-------|
| Date       | 2026-10-20 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/earnings-of-employees/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

An employee's total earnings are `months * salary`. Find the highest total earnings in `Employee`, and how many employees earned exactly that amount. Print both on one line.

## Intuition

Calculate total earnings for every employee, then group employees who have the same total. Each group gives one earnings value and its headcount. Sort from highest to lowest and keep the first group.

## Solution walkthrough

1. `months * salary AS total_earnings` calculates each employee's total.
2. `GROUP BY total_earnings` puts employees with the same total in the same group. `COUNT(*)` counts the employees in each group.
3. `ORDER BY total_earnings DESC` puts the highest total first.
4. `LIMIT 1` keeps only that group: the highest total and how many employees have it.

## SQL

```sql
SELECT 
    (months * salary) AS total_earnings, 
    COUNT(*)
FROM Employee
GROUP BY total_earnings
ORDER BY total_earnings DESC
LIMIT 1;
```

## Notes

`GROUP BY total_earnings` uses a column alias. MySQL allows this, but some other databases do not. Writing `GROUP BY months * salary` works in all of them.
