# Type of Triangle

| Field      | Value |
|------------|-------|
| Date       | 2026-10-20 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/what-type-of-triangle/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Each row of `TRIANGLES` has three side lengths, A, B and C. Label each row Equilateral, Isosceles, Scalene, or Not A Triangle.

## Intuition

`CASE` checks its conditions from top to bottom and stops at the first one that is true, so the order of the checks matters:

1. **Not A Triangle comes first.** If two sides add up to no more than the third, the sides cannot form a triangle. Without this check first, a row like (2, 2, 10) would be labelled Isosceles.
2. **Equilateral comes next**, because all three sides being equal also means two of them are equal. If the Isosceles check came first, equilateral triangles would be labelled Isosceles.
3. **Isosceles:** any two sides are equal.
4. **Scalene:** every other case.

## Solution walkthrough

1. The first `WHEN` applies the triangle rule to all three pairs of sides. If any pair adds up to no more than the remaining side, the row is Not A Triangle.
2. `A = B AND B = C` means all three sides are equal: Equilateral.
3. `A = B OR B = C OR A = C` means exactly two sides are equal, because the equilateral case was already caught: Isosceles.
4. `ELSE 'Scalene'` covers the rest, where no two sides are equal.

## SQL

```sql
SELECT 
    CASE  
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        ELSE 'Scalene'
    END
FROM TRIANGLES;
```
