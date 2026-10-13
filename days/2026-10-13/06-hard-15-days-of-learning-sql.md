# 15 Days of Learning SQL

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Hard |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem) |
| Dialect    | MySQL |
| Status     | Pending |

## Problem

A contest ran for 15 days, from 2016-03-01 to 2016-03-15. For **each day**, print:
1. `submission_date`
2. how many hackers made at least one submission **on every day from day 1 up to and including that day**
3. the `hacker_id` and `name` of the hacker with the most submissions **on that day**. If there's a tie, take the lowest `hacker_id`.

Tables: `Hackers(hacker_id, name)` and `Submissions(submission_date, submission_id, hacker_id, score)`.

## Intuition

The two numbers are unrelated, so work them out separately for each date and put them side by side.

**"Submitted every day so far"**: on day *d*, a hacker counts if they submitted on *d* **and** the number of distinct dates they submitted on before *d* equals the number of days before *d* in the contest, which is `DATEDIFF(d, '2016-03-01')`. On day 1 that number is 0, so everyone who submitted counts. On day 3 they need 2 earlier dates, and so on. Missing even one day makes the count fall short.

**"Top submitter today"**: group that day's submissions by hacker, sort by `COUNT(*) DESC, hacker_id ASC` and take `LIMIT 1`.

Get the name by joining `Hackers` at the end. This is cleaner than another subquery that refers to a column alias.

## Solution walkthrough

1. `d` = the list of distinct contest dates, which gives one output row per day.
2. `hackers`: a correlated subquery counts the distinct hackers `s2` who submitted on `d.submission_date`. For each of them, an inner subquery checks that their count of distinct earlier dates equals `DATEDIFF(d.submission_date, '2016-03-01')`.
3. `top_hacker`: another correlated subquery groups that day's submissions by hacker and picks the busiest one, with the lowest id winning ties.
4. The outer query joins `Hackers` to get the name, then sorts by date.

## SQL

```sql
SELECT t.submission_date,
       t.hackers,
       t.top_hacker,
       h.name
FROM (
    SELECT d.submission_date,
           (SELECT COUNT(DISTINCT s2.hacker_id)
            FROM Submissions s2
            WHERE s2.submission_date = d.submission_date
              AND (SELECT COUNT(DISTINCT s3.submission_date)
                   FROM Submissions s3
                   WHERE s3.hacker_id = s2.hacker_id
                     AND s3.submission_date < d.submission_date)
                  = DATEDIFF(d.submission_date, '2016-03-01')
           ) AS hackers,
           (SELECT s4.hacker_id
            FROM Submissions s4
            WHERE s4.submission_date = d.submission_date
            GROUP BY s4.hacker_id
            ORDER BY COUNT(*) DESC, s4.hacker_id
            LIMIT 1
           ) AS top_hacker
    FROM (SELECT DISTINCT submission_date FROM Submissions) d
) t
JOIN Hackers h ON h.hacker_id = t.top_hacker
ORDER BY t.submission_date;
```
