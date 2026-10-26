# Top Competitors

| Field      | Value |
|------------|-------|
| Date       | 2026-10-26 |
| Difficulty | Medium |
| Link       | [HackerRank](https://www.hackerrank.com/challenges/full-score/problem) |
| Dialect    | MySQL |
| Status     | Passed |

## Problem

Julia's contest has four tables: `Hackers` (hacker_id, name), `Difficulty` (difficulty_level, score), `Challenges` (challenge_id, hacker_id, difficulty_level) and `Submissions` (submission_id, hacker_id, challenge_id, score). Print the `hacker_id` and `name` of hackers who got a full score on **more than one** challenge. Sort by the number of full-score challenges, highest first, then by `hacker_id` ascending.

## Intuition

A "full score" isn't stored anywhere directly. It is the `score` in `Difficulty` for the challenge's difficulty level. So walk the chain from a submission to its full score:

`Submissions` -> `Challenges` (which difficulty?) -> `Difficulty` (what is full marks for that level?)

Once each submission sits next to its full mark, `WHERE s.score = d.score` keeps only the full-score submissions. After that it's a normal count per hacker with `GROUP BY` + `HAVING`.

## Solution walkthrough

1. `JOIN Hackers` brings in the hacker's name.
2. `JOIN Challenges` on `challenge_id` gives the challenge's `difficulty_level`.
3. `JOIN Difficulty` on `difficulty_level` gives the full score for that level.
4. `WHERE s.score = d.score` keeps only full-score submissions.
5. `GROUP BY h.hacker_id, h.name` makes one row per hacker.
6. `HAVING COUNT(s.challenge_id) > 1` keeps hackers with more than one full score. It's `HAVING`, not `WHERE`, because it filters on the count.
7. `ORDER BY COUNT(...) DESC, h.hacker_id ASC` applies both sort rules.

## SQL

```sql
SELECT 
    h.hacker_id, 
    h.name
FROM 
    Submissions s
JOIN 
    Hackers h ON s.hacker_id = h.hacker_id
JOIN 
    Challenges c ON s.challenge_id = c.challenge_id
JOIN 
    Difficulty d ON c.difficulty_level = d.difficulty_level
WHERE 
    s.score = d.score
GROUP BY 
    h.hacker_id, 
    h.name
HAVING 
    COUNT(s.challenge_id) > 1
ORDER BY 
    COUNT(s.challenge_id) DESC, 
    h.hacker_id ASC;
```

## Notes

Join `Challenges` on `challenge_id` only. `Challenges.hacker_id` is the person who **created** the challenge, not the one who submitted to it, so also joining on it would drop most rows.

If a hacker could get a full score on the same challenge twice, `COUNT(DISTINCT s.challenge_id)` would be the safer count. The HackerRank data passes either way.
