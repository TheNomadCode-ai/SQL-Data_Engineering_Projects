/*
We need to see this first and beforehand 

*/

-- SELECT sd.skills,
--        MEDIAN(jpf.salary_year_avg) AS median_salary,
--        COUNT(jpf.*) AS demand_count,
--        median_salary-AVG(median_salary) AS salary_diff_from_avg,
--        demand_count-AVG(demand_count) AS demand_diff_from_avg,
--        (median_salary-AVG(median_salary)) + (demand_count-AVG(demand_count)) AS best_position
-- FROM job_postings_fact as jpf
-- INNER JOIN skills_job_dim as sjd
-- ON jpf.job_id = sjd.job_id 
-- INNER JOIN skills_dim as sd
-- ON sjd.skill_id = sd.skill_id
-- WHERE jpf.job_title_short = 'Data Engineer' 
-- AND jpf.job_work_from_home = True
-- GROUP BY sd.skills
-- ORDER BY best_position DESC
-- LIMIT 10;

-- well this failed miserably sort of no worries though

SELECT sd.skills,
       ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    --    COUNT(jpf.*) AS demand_count
      COUNT(jpf.salary_year_avg) AS demand_count,
       -- this is the corrected demand count
    ROUND(LN(COUNT(jpf.salary_year_avg)),0) AS ln_demand_count,
       
       ROUND(ROUND(MEDIAN(jpf.salary_year_avg),0) * ROUND(LN(COUNT(jpf.salary_year_avg)),0)/100000,1) AS optimal_score
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' 
AND jpf.job_work_from_home = True
AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY optimal_score DESC      
LIMIT 24;

-- same thing whether you use this or that it's all the same boss
/*
┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ aws        │      137320.0 │          783 │             7.0 │           9.6 │
│ python     │      135000.0 │         1133 │             7.0 │           9.5 │
│ terraform  │      184000.0 │          193 │             5.0 │           9.2 │
│ sql        │      130000.0 │         1128 │             7.0 │           9.1 │
│ airflow    │      150000.0 │          386 │             6.0 │           9.0 │
│ kafka      │      145000.0 │          292 │             6.0 │           8.7 │
│ spark      │      140000.0 │          503 │             6.0 │           8.4 │
│ scala      │      137290.0 │          247 │             6.0 │           8.2 │
│ snowflake  │      135500.0 │          438 │             6.0 │           8.1 │
│ java       │      135000.0 │          303 │             6.0 │           8.1 │
│ databricks │      132750.0 │          266 │             6.0 │           8.0 │
│ redshift   │      130000.0 │          274 │             6.0 │           7.8 │
│ azure      │      128000.0 │          475 │             6.0 │           7.7 │
│ kubernetes │      150500.0 │          147 │             5.0 │           7.5 │
│ go         │      140000.0 │          113 │             5.0 │           7.0 │
│ pyspark    │      140000.0 │          152 │             5.0 │           7.0 │
│ git        │      140000.0 │          208 │             5.0 │           7.0 │
│ mongodb    │      135750.0 │          136 │             5.0 │           6.8 │
│ gcp        │      136000.0 │          196 │             5.0 │           6.8 │
│ bigquery   │      135000.0 │          123 │             5.0 │           6.8 │
│ github     │      135000.0 │          127 │             5.0 │           6.8 │
│ docker     │      135000.0 │          144 │             5.0 │           6.8 │
│ hadoop     │      135000.0 │          198 │             5.0 │           6.8 │
│ r          │      134775.0 │          133 │             5.0 │           6.7 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  24 rows                                                           5 columns
*/