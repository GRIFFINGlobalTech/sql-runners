# Signup Activation Rate

| Field      | Value |
|------------|-------|
| Date       | 2026-11-19 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/signup-confirmation-rate) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Tables: `emails(email_id, user_id, signup_date)` and `texts(text_id, email_id, signup_action)`. New users sign up with their email and are then sent a text to confirm the account. `signup_action` is either `'Confirmed'` or `'Not Confirmed'`. Find the activation rate: the share of signed-up users who confirmed, rounded to 2 decimal places.

## Intuition

The rate is confirmed users divided by all users. The denominator must include every email, even ones with no text at all, so the join has to start from `emails` and keep everyone. Only confirmed texts should attach, so the `'Confirmed'` filter goes in the `ON` clause. Then the numerator is just "how many emails got a match".

## Solution walkthrough

1. Start from `emails` and `LEFT JOIN texts`, so every signup stays in the result.
2. Put `texts.signup_action = 'Confirmed'` inside `ON`, not `WHERE`. In `WHERE` it would drop every email without a confirmed text, and the denominator would shrink to only confirmed users (rate = 1.00).
3. Numerator: `COUNT(DISTINCT texts.email_id)`. Unmatched emails have NULL here and `COUNT` skips NULLs. `DISTINCT` stops an email that confirmed more than once from being counted twice.
4. Denominator: `COUNT(DISTINCT emails.email_id)`, all signups.
5. Cast to `DECIMAL` before dividing. Two integers in PostgreSQL do integer division, so 0.33 would come out as 0.
6. `ROUND(..., 2)` for the 2 decimal places.

## SQL

```sql
SELECT 
  ROUND(
    COUNT(DISTINCT texts.email_id)::DECIMAL / COUNT(DISTINCT emails.email_id), 
    2
  ) AS confirm_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
```

## Notes

- Same "filter in ON keeps the zero rows" idea as IBM db2 Product Analytics (Day 17).
- `::DECIMAL` is PostgreSQL cast syntax. In MySQL `/` already returns a decimal, or use `CAST(x AS DECIMAL)`.
- Other way to write it: `SUM(CASE WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 END)` over the joined rows, but that counts texts, not emails, so it needs care if an email has several texts.
