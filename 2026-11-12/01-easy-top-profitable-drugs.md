# Top Profitable Drugs

| Field      | Value |
|------------|-------|
| Date       | 2026-11-12 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/top-profitable-drugs) |
| Dialect    | PostgreSQL |
| Status     | Passed |

## Problem

Table: `pharmacy_sales(product_id, units_sold, total_sales, cogs, manufacturer, drug)`. Each row is one drug. Find the top 3 most profitable drugs, where profit = `total_sales - cogs`. Output `drug` and `total_profit`, highest profit first.

## Intuition

Profit is a simple calculation on each row, so work it out per drug, sort it from biggest to smallest and keep the first three.

## Solution walkthrough

1. `total_sales - cogs AS total_profit` works out the profit for each drug.
2. `ORDER BY total_profit DESC` puts the most profitable drug first. The alias can be used in `ORDER BY` because sorting happens after `SELECT`.
3. `LIMIT 3` keeps the top three.

## SQL

```sql
SELECT drug ,total_sales - cogs AS total_profit
 FROM pharmacy_sales
 ORDER BY total_profit DESC
 LIMIT 3 ;
```

## Notes

- No `GROUP BY` is needed because each drug appears only once in the table. If a drug had several rows, it would need `SUM(total_sales) - SUM(cogs)` with `GROUP BY drug`.
- `cogs` means cost of goods sold, what the drug cost to make.
