# Teams Power Users

| Field      | Value |
|------------|-------|
| Date       | 2026-11-10 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/teams-power-users) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Table: `messages(message_id, sender_id, receiver_id, content, sent_date)`. Find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. Output `sender_id` and `message_count`, sorted from most to fewest.

## Intuition

Keep only August 2022 messages, count messages per sender, then take the top 2.

## Solution walkthrough

1. `WHERE sent_date >= '2022-08-01' AND sent_date < '2022-09-01'` keeps every message in August 2022, including ones sent late on the 31st.
2. `GROUP BY sender_id` with `COUNT(message_id)` counts messages per sender.
3. `ORDER BY message_count DESC LIMIT 2` keeps the two biggest senders.

## SQL

```sql
SELECT 
    sender_id, 
    COUNT(message_id) AS message_count
FROM messages
WHERE sent_date >= '2022-08-01' AND sent_date < '2022-09-01'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
```

## Notes

- The half-open range (`>=` start, `<` next month) is safer than `BETWEEN '2022-08-01' AND '2022-08-31'`, which would miss messages after midnight on the 31st when `sent_date` has a time part.
- It works on both MySQL and PostgreSQL and can use an index on `sent_date`, unlike wrapping the column in `MONTH()`/`EXTRACT()`.
