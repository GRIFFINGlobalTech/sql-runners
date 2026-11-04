# Page With No Likes

| Field      | Value |
|------------|-------|
| Date       | 2026-11-04 |
| Difficulty | Easy |
| Link       | [DataLemur](https://datalemur.com/questions/sql-page-with-no-likes) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Facebook has two tables: `pages(page_id, page_name)` and `page_likes(user_id, page_id, liked_date)`. Return the IDs of the pages that have zero likes, sorted by `page_id` ascending.

## Intuition

This is a `LEFT JOIN` question. `pages` is the left table because we want every page, liked or not. Join it to `page_likes` on `page_id`.

A page with likes finds matching rows in `page_likes`. A page with no likes finds no match, so every `page_likes` column comes back `NULL` for it. Keeping only the rows where `page_likes.page_id IS NULL` leaves the pages with 0 likes.

## Solution walkthrough

1. `FROM pages LEFT JOIN page_likes ON pages.page_id = page_likes.page_id` keeps every page and attaches its likes, if it has any.
2. `WHERE page_likes.page_id IS NULL` keeps only the pages that found no like.
3. `ORDER BY pages.page_id ASC` sorts the result as the question asks.

## SQL

```sql
SELECT pages.page_id FROM pages
LEFT JOIN page_likes 
ON pages.page_id = page_likes.page_id 
WHERE page_likes.page_id IS NULL
ORDER BY pages.page_id ASC;
```

## Notes

- This pattern is called an **anti-join**: you keep the rows on the left that have no match on the right.
- Check for `NULL` on the right table's join column, not on the left one. `pages.page_id` is never `NULL`, so filtering on it would return nothing.
- `NOT EXISTS` gives the same result:

```sql
SELECT p.page_id
FROM pages p
WHERE NOT EXISTS (SELECT 1 FROM page_likes pl WHERE pl.page_id = p.page_id)
ORDER BY p.page_id;
```
