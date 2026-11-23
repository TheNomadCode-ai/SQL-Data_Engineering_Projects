/*
we need to focus on these in demand skills for data engineers
we can focus more on remote job postings as of such
this is our first project here
now this is my turn to be earning for my family big big time

*/


-- SELECT *
-- FROM skills_job_dim; just did this to see what the table looks like really

-- SELECT DISTINCT  type
-- FROM skills_dim
-- LIMIT 10;

SELECT sd.skills,
       COUNT(jpf.*) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' 
AND jpf.job_work_from_home = True
GROUP BY sd.skills
ORDER BY COUNT(jpf.*) DESC      
LIMIT 10;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
data_jobs D 
*/

-- Not bad at all so you need to get sql locked in boss

