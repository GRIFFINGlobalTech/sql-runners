# New Companies

| Field      | Value |
|------------|-------|
| Date       | 2026-10-14 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/the-company/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Each company has a hierarchy: Founder → Lead Manager → Senior Manager → Manager → Employee. For every company, print `company_code`, the founder's name, and the total number of lead managers, senior managers, managers and employees. Order by `company_code` ascending.

Tables: `Company(company_code, founder)`, `Lead_Manager(lead_manager_code, company_code)`, `Senior_Manager(senior_manager_code, lead_manager_code, company_code)`, `Manager(manager_code, senior_manager_code, lead_manager_code, company_code)`, `Employee(employee_code, manager_code, senior_manager_code, lead_manager_code, company_code)`.

The tables may contain duplicate records, and `company_code` is a string, so `C_10` sorts before `C_2`.

## Intuition

Walk down the hierarchy one level at a time with joins, then count each level per company.

Joining the levels makes rows multiply: one lead manager with three senior managers turns into three rows, so the same lead manager is repeated. `COUNT(DISTINCT ...)` counts each code once, however many times it repeats. It also removes the duplicate records the question warns about.

`LEFT JOIN` keeps a company in the result even if a level below it is empty.

## Solution walkthrough

1. Start from `Company c`, so every company appears once per group.
2. `LEFT JOIN Lead_Manager` on `company_code`, then `Senior_Manager` on `lead_manager_code`, then `Manager` on `senior_manager_code`, then `Employee` on `manager_code`. Each join links a level to the one above it.
3. `GROUP BY c.company_code, c.founder` gives one row per company.
4. `COUNT(DISTINCT ...)` on each level's code counts the unique people at that level.
5. `ORDER BY c.company_code ASC` sorts by the code as text, which is what the grader expects.

## SQL

```sql
SELECT 
    c.company_code, 
    c.founder, 
    COUNT(DISTINCT lm.lead_manager_code), 
    COUNT(DISTINCT sm.senior_manager_code), 
    COUNT(DISTINCT m.manager_code), 
    COUNT(DISTINCT e.employee_code)
FROM Company c
LEFT JOIN Lead_Manager lm     ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm   ON lm.lead_manager_code = sm.lead_manager_code
LEFT JOIN Manager m           ON sm.senior_manager_code = m.senior_manager_code
LEFT JOIN Employee e          ON m.manager_code = e.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code ASC;
```

## Notes

Without `DISTINCT`, every count would come out as the number of joined rows (roughly the employee count), not the number of people at each level.
