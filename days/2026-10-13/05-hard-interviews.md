# Interviews

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Hard |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/interviews/problem) |
| Dialect    | MySQL |
| Status     | Pending |

## Problem

For each contest, print `contest_id, hacker_id, name` and the totals of `total_submissions`, `total_accepted_submissions`, `total_views` and `total_unique_views` across all of that contest's challenges. Skip contests where all four totals are 0. Sort by `contest_id`.

The chain is: `Contests` → `Colleges` → `Challenges` → (`View_Stats`, `Submission_Stats`).

## Intuition

**The trap is a fan-out.** One challenge can have many rows in `View_Stats` and also many rows in `Submission_Stats`. If you join both directly, every view row pairs with every submission row and the sums come out inflated.

The fix is to **aggregate each stats table per challenge first**, so each one has exactly one row per challenge, and then join. `LEFT JOIN` keeps challenges that have no stats, and `IFNULL(..., 0)` turns the resulting NULLs into zeros so the "all four are zero" check works.

## Solution walkthrough

1. `v` = views summed per `challenge_id`, and `s` = submissions summed per `challenge_id`.
2. Join Contests → Colleges → Challenges, then `LEFT JOIN` `v` and `s` on `challenge_id`. This is safe because each has one row per challenge.
3. `GROUP BY` the contest and sum the four columns.
4. `HAVING` removes contests where all four totals are 0.

## SQL

```sql
SELECT c.contest_id,
       c.hacker_id,
       c.name,
       SUM(IFNULL(s.total_submissions, 0))          AS total_submissions,
       SUM(IFNULL(s.total_accepted_submissions, 0)) AS total_accepted_submissions,
       SUM(IFNULL(v.total_views, 0))                AS total_views,
       SUM(IFNULL(v.total_unique_views, 0))         AS total_unique_views
FROM Contests c
JOIN Colleges   col ON col.contest_id = c.contest_id
JOIN Challenges ch  ON ch.college_id  = col.college_id
LEFT JOIN (
    SELECT challenge_id,
           SUM(total_views)        AS total_views,
           SUM(total_unique_views) AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) v ON v.challenge_id = ch.challenge_id
LEFT JOIN (
    SELECT challenge_id,
           SUM(total_submissions)          AS total_submissions,
           SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
) s ON s.challenge_id = ch.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING SUM(IFNULL(s.total_submissions, 0))
     + SUM(IFNULL(s.total_accepted_submissions, 0))
     + SUM(IFNULL(v.total_views, 0))
     + SUM(IFNULL(v.total_unique_views, 0)) > 0
ORDER BY c.contest_id;
```
