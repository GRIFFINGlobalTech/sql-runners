# Histogram of Tweets

| Field      | Value |
|------------|-------|
| Date       | 2026-11-04 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/sql-histogram-tweets) |
| Dialect    | MySQL |
| Status     | Failed |

## Problem

Table: `tweets(tweet_id, user_id, msg, tweet_date)`. Build a histogram of tweets per user in 2022: for each tweet count (the "bucket"), return how many users posted exactly that many tweets. Output `tweet_bucket` and `users_num`.

## Intuition

You have to count twice:

1. Count the tweets each user posted in 2022. That number is the user's bucket.
2. Count how many users fall into each bucket.

The second count groups by the result of the first one, so the first count has to exist before you can group by it. Do step 1 in a CTE (or subquery), then do step 2 on its result.

## Solution walkthrough

1. The `user_tweets` CTE keeps only tweets from 2022, groups by `user_id`, and counts tweets per user as `tweet_bucket`.
2. The outer query groups those rows by `tweet_bucket` and counts the users in each bucket as `users_num`.

## SQL (corrected solution)

```sql
WITH user_tweets AS (
    SELECT user_id, COUNT(tweet_id) AS tweet_bucket
    FROM tweets
    WHERE YEAR(tweet_date) = 2022
    GROUP BY user_id
)
SELECT tweet_bucket, COUNT(user_id) AS users_num
FROM user_tweets
GROUP BY tweet_bucket;
```

## Notes

> **Correction:** the first attempt tried to do both counts in one query and grouped by `tweet_bucket` in the same query that calculates it. The query above is the corrected solution. Status stays **Failed** to keep an honest record of the attempt.

**What the grader showed:** `Can't group on 'tweet_bucket'`.

**Why:** `tweet_bucket` is a `COUNT(...)`, and SQL computes aggregates *after* grouping. While SQL is grouping, the count doesn't exist yet, so you can't group by it. Calculating it first in a CTE turns it into an ordinary column that the next query can group by.

- If the editor is set to PostgreSQL, `YEAR()` doesn't exist. Use `EXTRACT(YEAR FROM tweet_date) = 2022` instead.
- A date range filter also works on both engines and can use an index: `tweet_date >= '2022-01-01' AND tweet_date < '2023-01-01'`.
