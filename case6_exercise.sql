-- How many users are there?

SELECT COUNT(DISTINCT user_id)
FROM users ;

-- How many cookies does each user have on average?

WITH count_cookies AS (
    SELECT user_id, COUNT(cookie_id) AS counting
    FROM users
    GROUP BY user_id
)

SELECT AVG(counting)
FROM count_cookies;

-- What is the unique number of visits by all users per month?

SELECT EXTRACT(MONTH FROM event_time), COUNT(DISTINCT visit_id)
FROM events 
GROUP BY EXTRACT(MONTH FROM event_time);

-- What is the number of events for each event type?

SELECT event_type, COUNT(*)
FROM events
GROUP BY event_type;

-- What is the percentage of visits which have a purchase event?

SELECT 100 * COUNT (DISTINCT ev.visit_id) / (SELECT COUNT(DISTINCT visit_id) FROM events)
FROM events AS ev
INNER JOIN event_identifier AS ei ON ev.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';

-- What is the percentage of visits which view the checkout page but do not have a purchase event?

SELECT 100 * COUNT (DISTINCT ev.visit_id) / (SELECT COUNT(DISTINCT visit_id) FROM events)
FROM events AS ev
INNER JOIN event_identifier AS ei ON ev.event_type = ei.event_type
WHERE ei.event_name = 'Page View' AND ei.event_name != 'Purchase';

-- What are the top 3 pages by number of views?

SELECT pah.page_id, pah.page_name, COUNT(*) AS num_of_views
FROM events AS ev 
INNER JOIN page_hierarchy AS pah ON ev.page_id = pah.page_id
WHERE event_type = '1'
GROUP BY page_id, page_name
ORDER BY num_of_views DESC
LIMIT 3;

-- What is the number of views and cart adds for each product category?

SELECT pah.product_category, 
SUM(CASE WHEN ev.event_type = '2' THEN 1 ELSE 0 END) AS type_cart_adding,
SUM(CASE WHEN ev.event_type = '1' THEN 1 ELSE 0 END) AS number_of_views
FROM events AS ev 
INNER JOIN page_hierarchy AS pah ON ev.page_id = pah.page_id
WHERE pah.product_category IS NOT NULL
GROUP BY pah.product_category;

-- What are the top 3 products by purchases?

SELECT pah.page_id, pah.page_name, COUNT(*) AS num_of_views
FROM events AS ev 
INNER JOIN page_hierarchy AS pah ON ev.page_id = pah.page_id
WHERE event_type = '3'
GROUP BY page_id, page_name
ORDER BY num_of_views DESC
LIMIT 3;


-- UPDATING . . . 

