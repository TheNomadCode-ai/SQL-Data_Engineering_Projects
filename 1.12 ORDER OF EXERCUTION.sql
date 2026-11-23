--hERE we are going to study about the order of exection

EXPLAIN
SELECT cd.name AS company_name,
          COUNT(jpf.*) AS posting_count
FROM job_postings_Fact as jpf
LEFT JOIN company_dim as cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_Country = 'United States'  
GROUP BY cd.name
HAVING posting_count > 3000 
ORDER BY posting_count DESC
LIMIT 10;
--here un the having because this is duckdb you can use the alias but 
-- if it was in case of other langauges you couldnt use it raja
-- but you can use the alias in order by
-- it is easy and kind of intellectualdssdfs
-sdfs