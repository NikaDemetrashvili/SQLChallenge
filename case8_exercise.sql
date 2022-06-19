-- Update the interest_metrics table by modifying the month_year column to be a date data type with the start of the month
ALTER TABLE interest_metrics 
MODIFY month_year DATA;

-- What is count of records in the interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?
SELECT month_year, COUNT(*)
FROM interest_metrics
WHERE monmonth_year = 'NULL'
GROUP BY month_year
ORDER BY month_year;

-- What do you think we should do with these null values in the interest_metrics
DELETE FROM interest_metrics
WHERE interest_id = 'NULL';

-- How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?
SELECT COUNT(DISTINCT ma.id), COUNT(me.interest_id), SUM(CASE WHEN ma.id = 'NULL' THEN 1 END), SUM(CASE WHEN me.interest_id = 'NULL' THEN 1 END)
FROM interest_map AS ma 
INNER JOIN interest_metrics AS me ON me.interest_id = ma.id;

-- Summarise the id values in the fresh_segments.interest_map by its total record count in this table
SELECT COUNT(*)
FROM interest_map;

-- What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from fresh_segments.interest_metrics and all columns from
SELECT *   
FROM interest_map AS ma 
INNER JOIN interest_metrics AS me ON ma.id = me.interest_id
WHERE me.interest_id = '21246'
ORDER BY me.interest_id;

-- Which interests have been present in all month_year dates in our dataset?
SELECT COUNT(DISTINCT month_year), COUNT(DISTINCT interest_id)
FROM interest_metrics;

-- UPDATING . . . 