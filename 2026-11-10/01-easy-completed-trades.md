# Cities With Completed Trades

| Field      | Value |
|------------|-------|
| Date       | 2026-11-10 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/completed-trades) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Tables: `trades(order_id, user_id, quantity, status, date, price)` and `users(user_id, city, email, signup_date)`. Return the top 3 cities with the most completed trade orders, sorted from most to fewest. Output `city` and `total_orders`.

## Intuition

The trade lives in `trades`, but the city lives in `users`. Join them on `user_id` so every trade knows its city, keep only the completed ones, then count orders per city and take the top 3.

## Solution walkthrough

1. `INNER JOIN users` on `user_id` attaches the user's city to each trade.
2. `WHERE t.status = 'Completed'` drops cancelled trades before anything is counted.
3. `GROUP BY u.city` with `COUNT(t.order_id)` gives the number of completed orders per city.
4. `ORDER BY total_orders DESC LIMIT 3` keeps the three busiest cities.

## SQL

```sql
SELECT 
    u.city, 
    COUNT(t.order_id) AS total_orders
FROM 
    trades t
INNER JOIN 
    users u ON t.user_id = u.user_id
WHERE 
    t.status = 'Completed'
GROUP BY 
    u.city
ORDER BY 
    total_orders DESC
LIMIT 3;
```

## Notes

- Filter in `WHERE`, not `HAVING`: the status is a row value, so it should be removed before grouping.
- `LIMIT 3` works in both MySQL and PostgreSQL.
