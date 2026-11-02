# Print Prime Numbers

| Field      | Value |
|------------|-------|
| Date       | 2026-10-28 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/print-prime-numbers/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Print all prime numbers up to 1000 on a single line, separated by `&` (for example `2&3&5&7`).

## Intuition

There is no table to read from, so the query has to make its own list of numbers. A **recursive CTE** does that: start at 2, keep adding 1 until 1000.

A number is prime if no smaller number (from 2 up) divides it evenly. "No such number exists" maps to `NOT EXISTS`. Finally, `GROUP_CONCAT` joins all the primes into one line.

## Solution walkthrough

1. `WITH RECURSIVE numbers` starts with `SELECT 2 AS n` (the anchor) and keeps adding `n + 1` while `n < 1000`. This gives the numbers 2 to 1000.
2. The outer query reads each number as `n1`.
3. `NOT EXISTS (...)` looks for a smaller number `n2` where `n1.n % n2.n = 0`, meaning `n2` divides `n1` with no remainder. If none is found, `n1` is prime and stays.
4. `GROUP_CONCAT(n SEPARATOR '&')` joins the kept numbers into one string with `&` between them.

## SQL

```sql
WITH RECURSIVE numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 1000
)
SELECT GROUP_CONCAT(n SEPARATOR '&')
FROM numbers n1
WHERE NOT EXISTS (
    SELECT 1 
    FROM numbers n2 
    WHERE n2.n < n1.n 
      AND n1.n % n2.n = 0
);
```

## Notes

The list starts at 2 on purpose. 1 is not prime, and starting at 1 would also break the check, because every number divides evenly by 1.

Two MySQL limits sit close by. The recursion stops at `cte_max_recursion_depth` (default 1000), and 2 to 1000 is 999 steps, so it just fits. `GROUP_CONCAT` cuts its output at `group_concat_max_len` (default 1024 characters), and the 168 primes come to about 640, so that fits too.

It is faster to check divisors only up to the square root (`n2.n * n2.n <= n1.n`), but up to 1000 the difference doesn't matter.
