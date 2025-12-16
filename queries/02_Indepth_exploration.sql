-- II. In-depth Exploration:
-- A. Is there a growing trend in the no. of orders placed over the past years?
-- Hint: We want you to find out if no. of orders placed has increased gradually in
-- each month, over the past years.

SELECT *
FROM `target.orders`
LIMIT 20

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) as Year,
  COUNT(order_id) as No_of_orders
FROM `target.orders`
GROUP BY Year
ORDER BY Year

-- B. Can we see some kind of monthly seasonality in terms of the no. of orders being placed?
-- Hint: We want you to find out if the no. of orders placed are at peak during
-- certain months.

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) as Year,
  EXTRACT(MONTH FROM order_purchase_timestamp) as Month,
  COUNT(order_id) as No_of_orders
FROM `target.orders`

GROUP BY Year,Month
ORDER BY Year,Month

-- C. During what time of the day, do the Brazilian customers mostly place their
-- orders? (Dawn, Morning, Afternoon or Night)
-- ● 0-6 hrs : Dawn
-- ● 7-12 hrs : Mornings
-- ● 13-18 hrs : Afternoon
-- ● 19-23 hrs : Night
-- Hint: We want you to categorize the hours of a day into the given time brackets/
-- intervals and find out during which intervals the Brazilian customers usually
-- order the most.

SELECT *
FROM `target.orders`
LIMIT 20


SELECT  
  CASE 
    WHEN EXTRACT(hour from order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn'
    WHEN EXTRACT(hour from order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Mornings'
    WHEN EXTRACT(hour from order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon'
    ELSE 'Night'
  END AS Customer_placing_orders,
  COUNT(*) AS No_of_orders
FROM `target.orders`
GROUP BY Customer_placing_orders
ORDER BY No_of_orders desc
