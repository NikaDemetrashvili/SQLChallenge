-- Case Study #1: Danny's Diner

-- CREATE TABLE sales(
--     customer_id VARCHAR(1),
--     order_date DATE,
--     product_id INT
-- );

-- INSERT INTO sales(customer_id, order_date, product_id) 
-- VALUES   ('A', '2021-01-01', '1'),
--   ('A', '2021-01-01', '2'),
--   ('A', '2021-01-07', '2'),
--   ('A', '2021-01-10', '3'),
--   ('A', '2021-01-11', '3'),
--   ('A', '2021-01-11', '3'),
--   ('B', '2021-01-01', '2'),
--   ('B', '2021-01-02', '2'),
--   ('B', '2021-01-04', '1'),
--   ('B', '2021-01-11', '1'),
--   ('B', '2021-01-16', '3'),
--   ('B', '2021-02-01', '3'),
--   ('C', '2021-01-01', '3'),
--   ('C', '2021-01-01', '3'),
--   ('C', '2021-01-07', '3');

-- SELECT * FROM sales;

-- CREATE TABLE members (
--     customer_id VARCHAR(1),
--     join_date TIMESTAMP
-- );

-- INSERT INTO members (customer_id, join_date)
-- VALUES ('A', '2021-01-07'),
-- ('B', '2021-01-09');

-- select * from members;

-- CREATE TABLE menu (
--     product_id INT,
--     product_name VARCHAR(5),
--     price INT
-- );

-- INSERT INTO menu(product_id, product_name, price)
-- VALUES ('1', 'sushi', '10'),
--   ('2', 'curry', '15'),
--   ('3', 'ramen', '12');

-- SELECT * FROM menu;



-- What is the total amount each customer spent at the restaurant?

-- SELECT s.customer_id, SUM(price)
-- FROM sales AS s 
-- INNER JOIN menu as m ON s.product_id = m.product_id
-- GROUP BY s.customer_id


-- How many days has each customer visited the restaurant?

-- SELECT customer_id, COUNT(DISTINCT(order_date)), product_id
-- FROM sales
-- GROUP BY customer_id, product_id


-- What was the first item from the menu purchased by each customer?

-- SELECT customer_id, MIN(order_date)
-- FROM sales
-- WHERE customer_id = 'A'

-- SELECT customer_id, MIN(order_date)
-- FROM sales
-- WHERE customer_id = 'B'

-- SELECT customer_id, MIN(order_date)
-- FROM sales
-- WHERE customer_id = 'C'

-- What is the most purchased item on the menu and how many times was it purchased by all customers?

-- SELECT COUNT(product_id) AS Most_Purchased_Item, product_name
-- FROM sales as s
-- JOIN menu as m 
--     ON s.product_id = m.product_id
-- GROUP BY product_name,product_id
-- ORDER BY product_id DESC;

-- Which item was the most popular for each customer?

-- SELECT s.customer_id, m.product_name, COUNT(m.product_id)
-- FROM menu as m 
-- INNER JOIN sales as s ON m.product_id = s.product_id
-- GROUP BY s.customer_id, m.product_name;

-- Which item was purchased first by the customer after they became a member?

-- SELECT s.customer_id, m.join_date, s.order_date
-- FROM sales as s 
-- INNER JOIN members as m ON s.customer_id = m.customer_id
-- WHERE s.order_date >= m.join_date;

-- SELECT s.customer_id, me.product_name, MIN(s.order_date)
-- FROM sales as s 
-- INNER JOIN menu as me ON s.product_id = me.product_id
-- GROUP BY s.customer_id, me.product_name  ;


-- What is the total items and amount spent for each member before they became a member?

-- SELECT s.customer_id, COUNT(DISTINCT s.product_id) AS Uniq_Item, SUM(me.price)
-- FROM sales as s 
-- INNER JOIN members as m ON s.customer_id = m.customer_id
-- INNER JOIN menu as me ON s.product_id = me.product_id
-- WHERE s.order_date < m.join_date
-- GROUP BY s.customer_id;
