# Average Review Ratings

| Field      | Value |
|------------|-------|
| Date       | 2026-11-12 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/sql-avg-review-ratings) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Table: `reviews(review_id, user_id, submit_date, product_id, stars)`. For each month and each product, find the average star rating. Output `mth`, `product` and `avg_stars` (rounded to 2 decimals), sorted by month and then by product.

## Intuition

Each output row is one (month, product) pair, so group by both and average the stars inside each group.

## Solution walkthrough

1. `EXTRACT(MONTH FROM submit_date)` pulls the month number (1-12) out of the review date.
2. `GROUP BY EXTRACT(MONTH FROM submit_date), product_id` makes one group per product per month.
3. `ROUND(AVG(stars), 2)` averages the stars in each group and rounds to 2 decimals.
4. `ORDER BY mth ASC, product ASC` sorts by month first, then by product inside each month.

## SQL

```sql
SELECT 
  EXTRACT(MONTH FROM submit_date) AS mth,
  product_id AS product,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY 
  EXTRACT(MONTH FROM submit_date), 
  product_id
ORDER BY 
  mth ASC, 
  product ASC;
```

## Notes

- The `GROUP BY` repeats the full `EXTRACT(...)` expression. PostgreSQL also accepts `GROUP BY mth, product` (and MySQL does too), but repeating the expression works everywhere.
- `EXTRACT(MONTH ...)` only gives the month, so June 2022 and June 2023 would land in the same group. That is fine here because the data covers one year.
- MySQL equivalent of the month: `MONTH(submit_date)`.
