# Binary Tree Nodes

| Field      | Value |
|------------|-------|
| Date       | 2026-10-15 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/binary-search-tree-1/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Table `BST(N, P)` holds a binary tree: `N` is a node and `P` is its parent. Print every node with its type, ordered by `N`:

- `Root` if the node has no parent.
- `Inner` if the node has a parent and at least one child.
- `Leaf` if the node has no children.

## Intuition

Each type comes from one question about the node:

- Does it have a parent? If `P` is `NULL`, it is the root.
- Does it have a child? A node has a child if its value shows up in the `P` column of some other row, which means some other node points to it as its parent.
- If neither is true, it is a leaf.

The order of the checks matters. The root also has children, so it has to be tested first or it would be labelled `Inner`.

## Solution walkthrough

1. Read every row of `BST` and pick the label with a `CASE`.
2. `WHEN P IS NULL THEN 'Root'` catches the one node with no parent.
3. `WHEN N IN (SELECT P FROM BST) THEN 'Inner'` checks whether any row lists this node as its parent.
4. `ELSE 'Leaf'` covers everything else.
5. `ORDER BY N` sorts the output by node value.

## SQL

```sql
SELECT N,
  CASE
    WHEN P IS NULL                  THEN 'Root'
    WHEN N IN (SELECT P FROM BST)   THEN 'Inner'
    ELSE 'Leaf'
  END
FROM BST
ORDER BY N;
```

## Notes

The subquery's `P` column contains a `NULL` (the root's parent). That is harmless with `IN`, because `IN` only needs one match. It would break `NOT IN`: `N NOT IN (..., NULL)` is never true, so a version written as "leaf if `N NOT IN (SELECT P FROM BST)`" returns no leaves at all.
