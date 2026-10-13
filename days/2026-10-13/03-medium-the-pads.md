# The PADS

| Field      | Value |
|------------|-------|
| Date       | 2026-10-13 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/the-pads/problem) |
| Dialect    | MySQL |
| Status     | Failed |

## Problem

Produce **two result sets** from `OCCUPATIONS(Name, Occupation)`. Occupation is one of Doctor, Professor, Singer or Actor.

1. Every name in alphabetical order, followed by the first letter of its occupation in parentheses, for example `Ashely(P)`.
2. One line per occupation: `There are a total of [count] [occupation]s.`, with the occupation in lowercase. Sort by count ascending, and break ties alphabetically by occupation.

Expected sample output:

```
Ashely(P)
Christeen(P)
Jane(A)
Jenny(D)
Julia(A)
Ketty(P)
Maria(A)
Meera(S)
Priya(S)
Samantha(D)
There are a total of 2 doctors.
There are a total of 2 singers.
There are a total of 3 actors.
There are a total of 3 professors.
```

## Intuition

These are **two independent queries in one submission**, run one after the other. HackerRank compares their combined output line by line.

- Query 1 is string building on each row: `CONCAT(Name, '(', LEFT(Occupation, 1), ')')`.
- Query 2 is an aggregate: `GROUP BY Occupation`, `COUNT(*)`, and `LOWER()` so "Doctor" becomes "doctor". The `s.` at the end of the format is a literal string.

## Solution walkthrough

1. **Query 1**: `LEFT(Occupation, 1)` takes the first letter, `CONCAT` wraps it in parentheses after the name, and `ORDER BY Name` sorts alphabetically.
2. **Query 2**: `GROUP BY Occupation` collapses the table to one row per occupation, and `COUNT(*)` counts the rows in each group.
3. `CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')` builds the sentence. MySQL converts the number to text inside `CONCAT`.
4. `ORDER BY COUNT(*), Occupation` puts the smallest count first and breaks ties alphabetically (doctor before singer, actor before professor).
5. Each query ends with `;`.

## SQL (corrected solution)

```sql
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
```

## Notes (if it fails)

> **Correction:** the original submission failed. The query in **SQL (corrected solution)** above is the corrected solution. Status stays **Failed** to keep an honest record of the attempt.

**What the grader showed (original submission):** `Wrong Answer`, 1/1 test case failed. The output was a 4-column grid of names with `NULL`s:

```
Aamina Ashley Christeen Eve
Julia Belvet Jane Jennifer
...
NULL Priyanka NULL NULL
```

**Why it was wrong:** that is the output of the **Occupations** pivot query (Doctor | Professor | Singer | Actor columns), not The PADS. The two problems use the same `OCCUPATIONS` table, so the wrong query still runs without an error. It just produces the wrong shape. The PADS needs **one column of plain strings**: the `Name(X)` lines followed by the `There are a total of ...` lines.

**Fix:** submit the two queries above on The PADS page, with the language set to **MySQL**.

**Other common ways this question fails:**
| Mistake | Effect |
|---------|--------|
| Submitting only one of the two queries | The output is missing half its lines |
| Joining them with `UNION` | The rows mix together and lose their order, because one `ORDER BY` applies to the whole union |
| `ORDER BY Occupation, COUNT(*)` (reversed) | Sorted alphabetically instead of by count |
| Forgetting `LOWER()` | `Doctors` instead of `doctors` |
| Leaving out the `.` or the `s` in `'s.'` | Text mismatch, so Wrong Answer |
| `SUBSTRING(Occupation, 0, 1)` | MySQL strings start at position 1, so position 0 returns an empty string. Use `LEFT(x, 1)` or `SUBSTRING(x, 1, 1)` |
