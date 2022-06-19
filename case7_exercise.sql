Case Study #7 - Balanced Tree Clothing Company

-- What was the total quantity sold for all products?
SELECT SUM (qty)
FROM sales;

-- What is the total generated revenue for all products before discounts?
SELECT (price * qty)
FROM sales;

-- What was the total discount amount for all products?
SELECT(discount * qty  * price) / 100
FROM sales;

-- How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id)
FROM sales;

-- What is the average unique products purchased in each transaction?
WITH products_purchased AS (
    SELECT txn_id, COUNT (DISTINCT prod_id) AS counting_products
    FROM sales 
    GROUP BY txn_id
)

SELECT ROUND(AVG(counting_products), 2)
FROM products_purchased;

