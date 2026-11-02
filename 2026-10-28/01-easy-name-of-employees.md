# Employee Names

| Field      | Value |
|------------|-------|
| Date       | 2026-10-28 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/name-of-employees/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

The `Employee` table has `employee_id`, `name`, `months` and `salary`. Print every employee's `name` in alphabetical order.

## Intuition

No filter and no maths here. Pick one column and sort it. `ORDER BY` on a text column sorts it alphabetically by default (ascending).

## Solution walkthrough

1. `SELECT name` returns only the name column.
2. `FROM Employee` reads the whole table, with no `WHERE`.
3. `ORDER BY name` sorts A to Z. `ASC` is the default, so it can be left out.

## SQL

```sql
SELECT name 
FROM Employee 
ORDER BY name;
```

## Notes

Don't add `DISTINCT`. Two employees can share a name, and the question wants every employee listed.
