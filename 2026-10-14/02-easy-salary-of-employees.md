# Employee Salaries

| Field      | Value |
|------------|-------|
| Date       | 2026-10-14 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/salary-of-employees/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

List the `name` of every employee who earns more than `2000` per month and has worked for fewer than `10` months. Sort the result by ascending `employee_id`.

`Employee(employee_id, name, months, salary)`

## Intuition

Two conditions that must both hold, so they go together with `AND`:
- `salary > 2000`
- `months < 10`

Only the name is needed, so select just that column.

## Solution walkthrough

1. `SELECT NAME` returns only the name column.
2. `FROM EMPLOYEE` sets the table.
3. `WHERE SALARY > 2000` keeps the higher earners. `>` is strict, so exactly 2000 is left out.
4. `AND MONTHS < 10` keeps only people with under 10 months of service.

## SQL

```sql
SELECT NAME
FROM EMPLOYEE
WHERE SALARY > 2000
  AND MONTHS < 10;
```

## Notes

The question asks for the result sorted by `employee_id`. This query has no `ORDER BY` and still passed, because MySQL happened to return the rows in primary-key order. That order is not guaranteed, so the safe version adds `ORDER BY employee_id;` at the end.
