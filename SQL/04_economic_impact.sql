-- IV. Impact on Economy: Analyze the money movement by e-commerce by looking at
-- order prices, freight and others.

-- A. Get the % increase in the cost of orders from year 2017 to 2018 (include
-- months between Jan to Aug only).

-- Hint: You can use the payment_value column in the payments table to get the
-- cost of orders.

SELECT *
FROM `target.payments`
LIMIT 20

select *
from `target.orders`
limit 20

WITH cte AS (
  SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS Year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Month,
    p.payment_value
  FROM `target.payments` AS p
  JOIN `target.orders` AS o 
    ON p.order_id = o.order_id
  WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) BETWEEN 2017 AND 2018
    AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
)

SELECT 
  Month,
  _2017,
  _2018,
  ROUND(((_2018 - _2017) / _2017) * 100, 2) AS percentage_difference
FROM (
  SELECT *
  FROM cte
  PIVOT(
    SUM(payment_value) FOR Year IN (2017 AS _2017, 2018 AS _2018)
  )
)
ORDER BY Month;

-- B. Calculate the Total & Average value of order price for each state.

-- Hint: We want you to fetch the total price and the average price of orders for
-- each state.

SELECT *
FROM `target.payments`
LIMIT 20

SELECT *
FROM `target.geolocation`
LIMIT 30

SELECT
  g.geolocation_state as State,
  ROUND(SUM(p.payment_value),2) as Total_price,
  ROUND(AVG(p.payment_value),2) as Average_price
FROM `target.payments` as p 
JOIN `target.orders` as o ON p.order_id = o.order_id 
JOIN `target.customers` as c ON o.customer_id = c.customer_id
JOIN `target.geolocation` as g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY g.geolocation_state
ORDER BY State

-- C. Calculate the Total & Average value of order freight for each state.

-- Hint: We want you to fetch the total freight value and the average freight value
-- of orders for each state.

SELECT *
FROM `target.order_items`
LIMIT 20

SELECT *
FROM `target.geolocation`
LIMIT 20

SELECT 
  g.geolocation_state as State,
  ROUND(SUM(o.freight_value),2) as Total_freight_value,
  ROUND(AVG(o.freight_value),2) as Average_freight_value
FROM `target.order_items` as o 
JOIN `target.sellers` as s ON o.seller_id = s.seller_id
JOIN `target.geolocation` as g ON s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY g.geolocation_state
ORDER BY g.geolocation_state
