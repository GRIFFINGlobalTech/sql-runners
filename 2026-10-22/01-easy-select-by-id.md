# Select By ID

| Field      | Value |
|------------|-------|
| Date       | 2026-10-22 |
| Difficulty | Easy |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/select-by-id/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

From `CITY`, return every column for the city whose `ID` is `1661`.

## Intuition

"Every column" is `SELECT *`. "The city whose ID is 1661" is a single equality filter. `ID` is the primary key, so only one row comes back.

## Solution walkthrough

1. `SELECT * FROM CITY` reads all columns of every row.
2. `WHERE ID = 1661` keeps only the row with that ID.

## SQL

```sql
SELECT * FROM CITY WHERE ID = 1661
```

## Notes

`SELECT *` is fine for practice. In real code, list the columns you need so the query doesn't change when someone adds a column to the table.
