# Challenges

| Field      | Value |
|------------|-------|
| Date       | 2026-10-28 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/challenges/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Julia asked her students to create coding challenges. The tables are `Hackers` (hacker_id, name) and `Challenges` (challenge_id, hacker_id). Print each student's `hacker_id`, `name` and the total number of challenges they created. Sort by the total, highest first, then by `hacker_id`.

The catch: if more than one student created the same number of challenges and that number is **less than the maximum**, leave all of those students out. Ties at the maximum stay in.

## Intuition

Counting challenges per hacker is easy: `JOIN` + `GROUP BY` + `COUNT`. The hard part is the filter. A hacker's count is kept if either:

- it equals the **highest** count anyone has (ties allowed), or
- it is a count that **only one hacker** has.

Both are questions about the counts themselves, so each one needs a subquery that first counts per hacker and then looks at those counts. Since the filter is on an aggregate, it goes in `HAVING`.

## Solution walkthrough

1. `JOIN Challenges` to `Hackers` and `GROUP BY c.hacker_id, h.name` gives one row per hacker with `COUNT(c.challenge_id) AS total_challenges`.
2. **Max subquery:** count per hacker, sort the counts `DESC`, `LIMIT 1`. This is the highest count.
3. **Unique-count subquery:** the inner query `t` counts per hacker, then the outer part groups those counts and keeps the ones with `HAVING COUNT(t.cnt) = 1`, meaning only one hacker has that count.
4. `HAVING total_challenges = (max) OR total_challenges IN (unique counts)` applies the rule.
5. `ORDER BY total_challenges DESC, c.hacker_id ASC` sorts as asked.

## SQL

```sql
SELECT 
    c.hacker_id, 
    h.name, 
    COUNT(c.challenge_id) AS total_challenges
FROM Hackers h
JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name
HAVING 
    total_challenges = (
        SELECT COUNT(challenge_id) AS max_cnt 
        FROM Challenges 
        GROUP BY hacker_id 
        ORDER BY max_cnt DESC 
        LIMIT 1
    )
    OR total_challenges IN (
        SELECT t.cnt 
        FROM (
            SELECT COUNT(*) AS cnt 
            FROM Challenges 
            GROUP BY hacker_id
        ) t
        GROUP BY t.cnt
        HAVING COUNT(t.cnt) = 1
    )
ORDER BY total_challenges DESC, c.hacker_id ASC;
```

## Notes

Example: if the counts are 50, 50, 30, 20, 20 and 10, the result keeps both 50s (they are the max), the 30 and the 10 (each is unique), and drops both 20s (tied, and below the max).

Using the alias `total_challenges` inside `HAVING` works in MySQL, but not in every database. SQL Server, for example, needs the full `COUNT(c.challenge_id)` repeated there.

The same count-per-hacker query is written three times. A `WITH counts AS (...)` CTE could hold it once and make the query shorter.
