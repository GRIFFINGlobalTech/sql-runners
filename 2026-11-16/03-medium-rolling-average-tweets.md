# Tweets' Rolling Averages

| Field      | Value |
|------------|-------|
| Date       | 2026-11-16 |
| Difficulty | Medium |
| Link       | [DataLemur](https://datalemur.com/questions/rolling-average-tweets) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Table: `tweets(user_id, tweet_date, tweet_count)`. For each user and each date, calculate the 3-day rolling average of tweets (the current day plus up to two days before it). Output `user_id`, `tweet_date` and `rolling_avg_3d` rounded to 2 decimals.

## Intuition

A rolling average needs to look at neighbouring rows without collapsing them, so this is a window function, not a `GROUP BY`. The window is "this row and the 2 rows before it", per user, in date order.

## Solution walkthrough

1. `PARTITION BY user_id` restarts the window for every user, so one user's tweets never mix into another's average.
2. `ORDER BY tweet_date` lines up each user's rows in date order so "preceding" means earlier days.
3. `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` sets the frame to the current row plus the two before it. On a user's first day the frame has 1 row, on the second day 2 rows, and from the third day on 3 rows.
4. `AVG(tweet_count) OVER (...)` averages the tweet counts inside that frame.
5. `ROUND(..., 2)` rounds to 2 decimals.

## SQL

```sql
SELECT 
  user_id, 
  tweet_date, 
  ROUND(
    AVG(tweet_count) OVER (
      PARTITION BY user_id 
      ORDER BY tweet_date 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2
  ) AS rolling_avg_3d
FROM tweets;
```

## Notes

- `ROWS` counts rows, not days. It works here because each user has one row per consecutive day. If days were missing, `RANGE BETWEEN INTERVAL '2 days' PRECEDING AND CURRENT ROW` would be the date-based version.
- Without the frame clause, `AVG ... OVER (ORDER BY ...)` defaults to a running average from the first row, not a 3-day one.
- MySQL 8+ supports the same window syntax.
