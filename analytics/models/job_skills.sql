{{ config(materialized = 'view') }}

SELECT
    job_id,
    skill_keyword
FROM {{ source('raw', 'job_skills') }}