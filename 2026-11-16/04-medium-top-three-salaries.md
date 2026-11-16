# Top Three Salaries

| Field      | Value |
|------------|-------|
| Date       | 2026-11-16 |
| Difficulty | Medium |
| Link       | [DataLemur](https://datalemur.com/questions/sql-top-three-salaries) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Tables: `employee(employee_id, name, salary, department_id, manager_id)` and `department(department_id, department_name)`. Find the employees with the top three salaries in each department. If several people share a salary, they all count as the same level, so a department can return more than three people. Output `department_name`, `name` and `salary`, sorted by department name, then salary descending, then name.

## Intuition

"Top N per group" is a ranking window function partitioned by the group. Ties must share a level and the next level must not be skipped, so `DENSE_RANK` is the right one (not `RANK` or `ROW_NUMBER`).

## Solution walkthrough

1. Join `employee` to `department` to get the department name for each employee.
2. `DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC)` ranks salaries inside each department, highest = 1. Equal salaries get the same rank and the next salary gets the next number (1, 2, 2, 3).
3. Wrap it in a CTE (`ranked_employees`) because a window function result cannot be filtered in the same query's `WHERE`.
4. Keep rows with `salary_rank <= 3`.
5. Sort by `department_name ASC, salary DESC, name ASC`.

## SQL

```sql
WITH ranked_employees AS (
  SELECT 
    d.department_name,
    e.name,
    e.salary,
    DENSE_RANK() OVER (
      PARTITION BY e.department_id 
      ORDER BY e.salary DESC
    ) AS salary_rank
  FROM employee e
  INNER JOIN department d 
    ON e.department_id = d.department_id
)
SELECT 
  department_name,
  name,
  salary
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY 
  department_name ASC, 
  salary DESC, 
  name ASC;
```

## Notes

- `RANK` would give 1, 2, 2, 4 and could drop the third salary level. `ROW_NUMBER` would give 1, 2, 3, 4 and cut people who tie.
- Same CTE-then-filter pattern as the Day 13 Histogram of Tweets fix: compute first, filter in the outer query.
