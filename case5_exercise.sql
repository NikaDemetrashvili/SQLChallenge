-- Data Cleansing Steps

CREATE TEMPORARY TABLE clean_weekly_sales AS (
    SELECT STR_TO_DATE(week_date, '%d/%m/%y') AS week_date,
    WEEK (STR_TO_DATE(week_date, '%d/%m/%y')) AS week_number,
    MONTH (STR_TO_DATE(week_date, '%d/%m/%y')) AS month_number,
    YEAR (STR_TO_DATE(week_date, '%d/%m/%y')) AS year_number,
    region,
    platfor,
    segment,
    CASE WHEN RIGHT(segment, 1) = '1' THEN "Young Adults"
        WHEN RIGHT(segment, 1) = '2' THEN "Middle Aged"
        WHEN RIGHT(segment, 1) IN ('3','4') THEN "Retirees"
        ELSE 'unknown' END AS age_band,
    CASE WHEN LEFT(segment,1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'unknown' END AS demographic,
    transactions,
    ROUND((CONVERT(sales, SIGNED)/transactions), 2) AS avg_transactions,
    sales
    FROM weekly_sales
);
SELECT * FROM clean_weekly_sales;

-- Data Exploration

-- What day of the week is used for each week_date value?
SELECT DISTINCT(DATE_FORMAT(week_date, '%a'))
FROM clean_weekly_sales;

-- How many total transactions were there for each year in the dataset?
SELECT year_number, SUM(transactions)
FROM clean_weekly_sales
GROUP BY year_number
ORDER BY year_number;

-- What is the total sales for each region for each month?
SELECT month_number, region, SUM(sales)
FROM clean_weekly_sales
GROUP BY month_number, region
ORDER BY month_number

-- What is the total count of transactions for each platform
SELECT platfor, SUM(transactions)
FROM clean_weekly_sales
GROUP BY platfor
ORDER BY SUM(transactions)

-- What is the percentage of sales for Retail vs Shopify for each month?
WITH trans AS (
    SELECT platform, year_number, month_number, SUM(sales)
    FROM clean_weekly_sales
    GROUP BY platform, year_number, month_number
)

SELECT year_number, month_number

-- Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
SELECT platfor, year_number, ROUND(AVG(avg_transactions), 2), SUM(sales)/ SUM(transactions)
FROM clean_weekly_sales
GROUP BY platfor, year_number
ORDER BY year_number


-- Before & After Analysis

What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
SELECT DISTINCT(week_number)
FROM clean_weekly_sales
WHERE year_number = '2020' AND week_date = '2020-06-15'


-- UPDATING . . . 
