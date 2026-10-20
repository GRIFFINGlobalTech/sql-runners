# The Blunder

| Field      | Value |
|------------|-------|
| Date       | 2026-10-20 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/the-blunder/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Samantha averaged the salaries in `EMPLOYEES`, but her keyboard's 0 key was broken, so every salary was typed without its zeros. Find the difference between her wrong average and the real average, rounded up to the next whole number.

## Intuition

You can recreate the mistake inside the query. `REPLACE(Salary, '0', '')` removes every zero, which gives the salaries as Samantha typed them. Average both the real salaries and the zero-free ones, subtract the second from the first, and round up with `CEIL`.

## Solution walkthrough

1. `AVG(Salary)` is the real average.
2. `REPLACE(Salary, '0', '')` turns each salary into text, removes every `0`, and MySQL turns the result back into a number. For example, 1020 becomes 12.
3. `AVG(REPLACE(...))` is the average Samantha calculated.
4. Real average minus wrong average is the error. It is never negative, because removing zeros can only make a number smaller.
5. `CEIL(...)` rounds the error up, as the question asks.

## SQL

```sql
SELECT CEIL(AVG(Salary) 
- AVG(REPLACE(Salary, '0', ''))) FROM EMPLOYEES;
```

## Notes

The question asks to round **up**, so it is `CEIL`. `ROUND` would round some values down.
