WITH posting_ids AS (
    SELECT DISTINCT job_id
    FROM {{ ref('job_postings') }}
),

total AS (
    SELECT COUNT(*) AS total_postings
    FROM posting_ids
)

SELECT
    s.skill_keyword AS skill,
    COUNT(DISTINCT s.job_id) AS postings,
    ROUND(100.0 * COUNT(DISTINCT s.job_id) / (SELECT total_postings FROM total), 1) AS pct_of_postings
FROM {{ ref('job_skills') }} AS s
INNER JOIN posting_ids USING (job_id)
GROUP BY s.skill_keyword
ORDER BY postings DESC
LIMIT 20