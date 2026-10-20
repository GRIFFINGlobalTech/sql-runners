# Placements

| Field      | Value |
|------------|-------|
| Date       | 2026-10-20 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/placements/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

There are three tables: `Students` (ID, Name), `Friends` (ID, Friend_ID, one best friend per student) and `Packages` (ID, Salary offered). List the students whose best friend got a higher salary offer than they did. Sort them by the best friend's salary, from lowest to highest.

## Intuition

Each output row needs two salaries side by side: the student's and the best friend's. Both salaries are in the same `Packages` table, so join `Packages` twice under two aliases:

- `p1` joins on the student's ID, so it holds the student's salary.
- `p2` joins on the friend's ID, so it holds the friend's salary.

After that, the question is a simple `WHERE` comparison between the two.

## Solution walkthrough

1. `Students s JOIN Friends f ON s.ID = f.ID` attaches each student's best friend.
2. `JOIN Packages p1 ON s.ID = p1.ID` adds the student's own salary.
3. `JOIN Packages p2 ON f.Friend_ID = p2.ID` adds the friend's salary.
4. `WHERE p2.Salary > p1.Salary` keeps only the students whose friend was offered more.
5. `ORDER BY p2.Salary` sorts by the friend's salary, as the question asks. It sorts lowest first by default.

## SQL

```sql
SELECT s.Name 
FROM Students s 
JOIN Friends f ON s.ID = f.ID 
JOIN Packages p1 ON s.ID = p1.ID 
JOIN Packages p2 ON f.Friend_ID = p2.ID 
WHERE p2.Salary > p1.Salary 
ORDER BY p2.Salary;
```

## Notes

The pattern here is joining the same table twice under two aliases. Use it whenever you need two different rows from one table on the same output line, such as an employee and their manager, or a student and their friend.
