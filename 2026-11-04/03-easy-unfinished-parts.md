# Unfinished Parts

| Field      | Value |
|------------|-------|
| Date       | 2026-11-04 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/tesla-unfinished-parts) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Tesla tracks car parts as they go through the assembly line in `parts_assembly(part, finish_date, assembly_step)`. A part that hasn't finished assembly has no `finish_date`. Return the `part` and `assembly_step` of every unfinished part.

## Intuition

"Unfinished" means no finish date has been recorded, and in SQL that shows up as `NULL`. So filter for `finish_date IS NULL`.

## Solution walkthrough

1. `SELECT part, assembly_step` returns only the two columns the question asks for.
2. `WHERE finish_date IS NULL` keeps the parts that haven't finished.

## SQL

```sql
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;
```

## Notes

- Always use `IS NULL`, never `= NULL`. Comparing anything to `NULL` with `=` gives `NULL`, not true, so `WHERE finish_date = NULL` returns no rows.
