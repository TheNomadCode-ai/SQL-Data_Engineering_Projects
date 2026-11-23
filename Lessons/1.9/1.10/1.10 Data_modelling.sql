SELECT 
job_id,
job_title_short,
salary_year_avg,
company_id
FROM job_postings_fact
LIMIT 10;


SELECT
company_id,
name
FROM company_dim
LIMIT 10;

SELECT *
FROM information_schema.tables 
WHERE table_catalog = 'data_jobs';

SELECT *
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

-- this shit is kind of getting confusing sort of
PRAGMA show_tables;