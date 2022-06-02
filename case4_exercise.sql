-- How many unique nodes are there on the Data Bank system?
SELECT COUNT(DISTINCT node_id)
FROM customer_nodes;

-- What is the number of nodes per region?
SELECT r.region_id, r.region_name, COUNT(c.node_id)
FROM regions as r
INNER JOIN customer_nodes as c
ON r.region_id = c.region_id
GROUP BY r.region_id, r.region_name
ORDER BY r.region_id;

-- How many customers are allocated to each region?
SELECT r.region_id, r.region_name, COUNT(customer_id)
FROM regions as r
INNER JOIN customer_nodes as c
ON r.region_id = c.region_id
GROUP BY r.region_id, r.region_name
ORDER BY r.region_id;

-- How many days on average are customers reallocated to a different node?

WITH different_node AS (
    SELECT customer_id, region_id, node_id, end_date - start_date AS difference
    FROM customer_nodes
    WHERE end_date <> '9999-12-31'
    GROUP BY customer_id, region_id, node_id
    ORDER BY customer_id
),

WITH sum_difference AS (
    SELECT customer_id, region_id, node_id, COUNT(difference) AS count_sum_difference
    FROM customer_nodes
    GROUP BY customer_id, region_id, node_id
)

SELECT AVG(count_sum_difference)
FROM sum_difference;

-- What is the unique count and total amount for each transaction type?
SELECT txn_type, SUM(txn_amount), COUNT(*)
FROM customer_transactions
GROUP BY txn_type
ORDER BY SUM(txn_amount);

-- What is the average total historical deposit counts and amounts for all customers?
WITH historical_deposit AS (
    SELECT customer_id, txn_type, AVG(txn_amount) AS Amount, COUNT(*) AS Count_T
    FROM customer_transactions
    GROUP BY customer_id, txn_type
)

SELECT ROUND(AVG(Count_T),2), ROUND(AVG(Amount),2)
FROM historical_deposit
WHERE txn_type = 'deposit';

-- For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
WITH transactions_each_month AS (
    SELECT customer_id, MONTH(txn_date) AS date_in_month
    SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS c_withdrawal
    SUM(CASE WHEN txn_type = 'deposit' THEN 0 ELSE 1 END) AS c_deposit
    SUM(CASE WHEN txn_type = 'purchase' THEN 0 ELSE 1 END) AS c_purchase
    FROM customer_transactions
    GROUP BY customer_id, date_in_month
)

SELECT COUNT(DISTINCT customer_id), date_in_month
FROM transactions_each_month
WHERE c_deposit >= 2 AND (c_withdrawal > 1 OR c_purchase > 1)
GROUP BY date_in_month
ORDER BY date_in_month


-- UPDATING . . .

