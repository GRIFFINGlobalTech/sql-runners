# IBM db2 Product Analytics

| Field      | Value |
|------------|-------|
| Date       | 2026-11-17 |
| Difficulty | Medium |
| Link       | [DataLemur](https://datalemur.com/questions/sql-ibm-db2-product-analytics) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Tables: `queries(employee_id, query_id, query_starttime, execution_time)` and `employees(employee_id, full_name, gender)`. Build a histogram of how many unique queries each employee ran in Q3 2023 (July 1 to September 30). Output `unique_queries` and `employee_count`, sorted by `unique_queries`. Employees who ran no queries in that period must appear in the zero bucket.

## Intuition

A histogram is two levels of counting: first count queries per employee, then count employees per query total. That means two `GROUP BY`s, so the inner count goes in a subquery. The zero bucket is the trap: an employee with no Q3 queries has no rows in `queries`, so the join has to start from `employees` and keep everyone.

## Solution walkthrough

1. Start from `employees` and `LEFT JOIN queries`, so every employee stays even with no matching queries.
2. Put the Q3 date filter inside the `ON` clause, not in `WHERE`. In `ON` it only decides which queries attach; in `WHERE` it would drop the employees whose query columns are NULL and lose the zero bucket.
3. `>= '2023-07-01' AND < '2023-10-01'` covers the whole of September 30, including times late in the day, which `<= '2023-09-30'` would miss on a timestamp column.
4. Inner query: `GROUP BY e.employee_id` with `COUNT(DISTINCT q.query_id)`. `COUNT` ignores NULLs, so employees with no queries get 0.
5. Outer query: `GROUP BY unique_queries` and `COUNT(employee_id)` turns per-employee totals into the histogram, ordered by bucket.

## SQL

```sql
SELECT 
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM (
  SELECT 
    e.employee_id,
    COUNT(DISTINCT q.query_id) AS unique_queries
  FROM employees e
  LEFT JOIN queries q 
    ON e.employee_id = q.employee_id
    AND q.query_starttime >= '2023-07-01' 
    AND q.query_starttime < '2023-10-01'
  GROUP BY e.employee_id
) AS employee_counts
GROUP BY unique_queries
ORDER BY unique_queries ASC;
```

## Notes

- Same two-level histogram pattern as Histogram of Tweets (Day 13); this one adds the LEFT JOIN zero bucket.
- `COUNT(q.query_id)` vs `COUNT(*)`: `COUNT(*)` would count the NULL row from the LEFT JOIN as 1, so a zero-query employee would land in bucket 1.
- Works the same in MySQL; only the subquery alias is required there too.
