--here we will be learning to join and shtis
SELECT 
jpf.job_id,
jpf.job_title_short,
cd.name AS company_name,
jpf.job_location
FROM job_postings_fact AS jpf
LEFT JOIN  company_dim as cd
ON jpf.company_id = cd.company_id;


--We are only going to see Left join coz yu dont need right join cuh
SELECT 
jpf.job_id,
jpf.job_title_short,
cd.name AS company_name,
jpf.job_location
FROM job_postings_fact as jpf
INNER JOIN company_dim as cd
ON jpf.company_id = cd.company_id;

-- we can use full outer join to combine everything and we get same result cozzzz of the dataset cuh
SELECT 
jpf.job_id,
jpf.job_title_short,
cd.name AS company_name,
jpf.job_location
FROM job_postings_fact as jpf
FULL OUTER JOIN company_dim as cd
ON jpf.company_id = cd.company_id;

