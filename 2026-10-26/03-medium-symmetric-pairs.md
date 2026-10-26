# Symmetric Pairs

| Field      | Value |
|------------|-------|
| Date       | 2026-10-26 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/symmetric-pairs/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

`Functions(X, Y)` holds pairs of numbers. Two pairs (X1, Y1) and (X2, Y2) are symmetric if X1 = Y2 and X2 = Y1. Print every symmetric pair once, with X <= Y, sorted by X ascending.

## Intuition

There are two different cases. Solve each one separately and stack the results with `UNION ALL`:

- **X < Y**, e.g. (20, 21). It is symmetric if the flipped row (21, 20) also exists. Keeping only `X < Y` prints each pair once, from its smaller side.
- **X = Y**, e.g. (20, 20). It flips to itself, so one row isn't enough. The same row has to appear **at least twice**, which is `GROUP BY X, Y HAVING COUNT(*) > 1`.

## Solution walkthrough

1. First half: `WHERE X < Y` plus `EXISTS (...)` keeps a row only if another row has its values swapped (`f2.X = Functions.Y AND f2.Y = Functions.X`).
2. Second half: `WHERE X = Y`, grouped by the pair, with `HAVING COUNT(*) > 1` keeps self-pairs that appear more than once.
3. `UNION ALL` stacks both halves. They can't overlap (X < Y vs X = Y), so no de-duplication is needed.
4. `ORDER BY X` at the end sorts the combined result.

## SQL

```sql
SELECT X, Y 
FROM Functions
WHERE X < Y 
  AND EXISTS (
      SELECT 1 
      FROM Functions AS f2 
      WHERE f2.X = Functions.Y AND f2.Y = Functions.X
  )

UNION ALL

SELECT X, Y 
FROM Functions
WHERE X = Y
GROUP BY X, Y
HAVING COUNT(*) > 1

ORDER BY X;
```

## Notes

The trap in this question is the X = Y case. A row like (20, 20) matches its own flip, so a plain self-join or `EXISTS` would call it symmetric even when it appears only once. That's why it needs the `COUNT(*) > 1` check.

If the table held the same X < Y row twice, the first half would print it twice. `SELECT DISTINCT X, Y` in that half would cover it.
