SELECT * FROM casestudy_1.operations;

-- Calculate the number of jobs reviewed per hour per day for November 2020--
SELECT DS,ROUND(1.0* COUNT(JOB_ID)*3600/SUM(TIME_SPENT),2) As throughput
FROM casestudy_1.operations
WHERE EVENT_ IN ( 'transfer','decision')
AND DS BETWEEN'2020-11-01'AND '2020-11-30'
GROUP BY DS;

--  Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput--
WITH CTE AS (
SELECT DS, COUNT(JOB_ID) AS NUM_JOBS,SUM(TIME_SPENT) AS TOTAL_TIME
FROM casestudy_1.operations
WHERE EVENT_ IN('transfer','decision')
AND DS BETWEEN '2020-11-01' AND'2020-11-30'
GROUP BY DS
)
SELECT DS, ROUND(1.0* SUM(NUM_JOBS) OVER (ORDER BY DS ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)/SUM(TOTAL_TIME) OVER (ORDER BY DS ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS throughput_7d
FROM CTE;

--  Calculate the percentage share of each language in the last 30 days--
WITH CTE AS(
SELECT LANGUAGE_, COUNT(JOB_ID) AS NUM_JOBS
FROM casestudy_1.operations
WHERE EVENT_ IN('transfer','decision')
AND DS BETWEEN '2020-11-01' AND'2020-11-30'
GROUP BY 1
),
TOTAL AS(
SELECT COUNT(JOB_ID) AS TOTAL_JOBS
FROM casestudy_1.operations
WHERE EVENT_ IN ('transfer','decision')
AND DS BETWEEN '2020-11-01' AND'2020-11-30'
)
SELECT LANGUAGE_,ROUND(100.0* NUM_JOBS/TOTAL_JOBS,2) AS PERC_JOBS
FROM CTE
CROSS JOIN TOTAL
ORDER BY PERC_JOBS DESC;

-- Let’s say you see some duplicate rows in the data. How will you display duplicates from the table --
WITH CTE AS(
SELECT * ,
 ROW_NUMBER()OVER (PARTITION BY DS,JOB_ID,ACTOR_ID) AS ROWNUM
FROM casestudy_1.operations
)
SELECT * 
FROM CTE;
