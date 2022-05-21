-- Based off the 8 sample customers provided in the sample from the subscriptions table,
--  write a brief description about each customer’s onboarding journey.

SELECT s.customer_id, p.plan_id, s.start_date
FROM plans AS p 
INNER JOIN subscriptions as s ON p.plan_id = s.plan_id
WHERE customer_id IN (1, 2, 11, 13, 15, 16, 18, 19);


-- How many customers has Foodie-Fi ever had?

SELECT COUNT(DISTINCT customer_id)
FROM subscriptions;

-- What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

SELECT MONTH(start_date) AS Date_Month,
DATE_FORMAT(start_date, "%M"),
COUNT(*)
FROM subscriptions as s 
INNER JOIN plans as p ON s.plan_id = p.plan_id
WHERE s.plan_id = 0
GROUP BY MONTH(start_date), DATE_FORMAT(start_date, "%M")
ORDER BY Date_Month;

-- What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

SELECT p.plan_id, p.plan_name, COUNT(*)
FROM subscriptions as s 
INNER JOIN plans as p ON s.plan_id = p.plan_id
WHERE s.start_date >= "2021-01-01"
GROUP BY p.plan_id, p.plan_name
ORDER BY p.plan_id;

-- What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

SELECT COUNT(*) AS customer_count,
COUNT(*)*100 / (SELECT COUNT(DISTINCT customer_id)FROM subscriptions) AS churned_percentage
FROM subscriptions AS s 
INNER JOIN plans AS p ON s.plan_id = p.plan_id
WHERE s.plan_id = 4;


-- How many customers have upgraded to an annual plan in 2020?

SELECT COUNT(DISTINCT customer_id)
FROM subscriptions
WHERE plan_id = 3 AND start_date >= "2020-01-01"


-- Updating . . . 