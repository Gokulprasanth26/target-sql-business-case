-- V. Analysis based on sales, freight and delivery time.

-- A. Find the no. of days taken to deliver each order from the order’s purchase date
-- as delivery time.
-- Also, calculate the difference (in days) between the estimated & actual delivery
-- date of an order.
-- Do this in a single query.

-- Hint: You can calculate the delivery time and the difference between the
-- estimated & actual delivery date using the given formula:
-- ● time_to_deliver = order_delivered_customer_date -
-- order_purchase_timestamp
-- ● diff_estimated_delivery = order_estimated_delivery_date -
-- order_delivered_customer_date

SELECT *
FROM `target.orders`
LIMIT 10

SELECT 
  DISTINCT order_id,
  DATE_DIFF(order_delivered_customer_date,order_purchase_timestamp,DAY) AS delivery_time,
  DATE_DIFF(order_estimated_delivery_date,order_delivered_customer_date,DAY) AS diff_estimated_delivery 
FROM `target.orders`

-- B. Find out the top 5 states with the highest & lowest average freight value.

-- Hint: We want you to find the top 5 & the bottom 5 states arranged in
-- increasing order of the average freight value.

SELECT *
FROM `target.order_items`
LIMIT 10

SELECT *
FROM `target.geolocation`
LIMIT 10

WITH avg_filter as
(SELECT
  g.geolocation_state as State,
  ROUND(AVG(o.freight_value),2) as avg_freight_value
FROM `target.order_items` as o 
JOIN `target.sellers` as s ON o.seller_id = s.seller_id
JOIN `target.geolocation` as g ON s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY g.geolocation_state)

SELECT *
FROM(
(SELECT *
FROM avg_filter
ORDER BY avg_freight_value
LIMIT 5)
UNION ALL
(SELECT *
FROM avg_filter
ORDER BY avg_freight_value desc
LIMIT 5))
ORDER BY avg_freight_value

-- C. Find out the top 5 states with the highest & lowest average delivery time.
	
-- Hint: We want you to find the top 5 & the bottom 5 states arranged in
-- increasing order of the average delivery time.

SELECT *
FROM `target.orders`
LIMIT 10

WITH deli as 
(SELECT
  o.order_id,
  DATE_DIFF(o.order_estimated_delivery_date,o.order_delivered_customer_date,day) as delivery_time,
  c.customer_id,
  c.customer_zip_code_prefix
FROM `target.orders` as o 
JOIN `target.customers` as c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
),

state_avg_delivery as 
(SELECT 
  g.geolocation_state as State,
  ROUND(AVG(d.delivery_time),2) as avg_delivery_time
FROM deli as d 
JOIN `target.geolocation` as g ON d.customer_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY g.geolocation_state)

SELECT *
FROM
((SELECT
  State,
  avg_delivery_time
FROM state_avg_delivery
ORDER BY avg_delivery_time
LIMIT 5)

UNION ALL

(SELECT
  State,
  avg_delivery_time
FROM state_avg_delivery
ORDER BY avg_delivery_time DESC
LIMIT 5))
ORDER BY avg_delivery_time

-- D. Find out the top 5 states where the order delivery is really fast as compared to
-- the estimated date of delivery.

-- You can use the difference between the averages of actual & estimated delivery
-- date to figure out how fast the delivery was for each state.

-- Hint: Include only the orders that are already delivered.

SELECT *
FROM `target.orders`
LIMIT 50

WITH diff_date as
(SELECT 
  g.geolocation_state as State,
  CAST(ROUND(AVG(TIMESTAMP_DIFF(o.order_estimated_delivery_date,o.order_delivered_customer_date,DAY)),2) AS INT64) as date_before_estimated
FROM `target.orders` as o 
JOIN `target.customers` as c ON o.customer_id = c.customer_id
JOIN `target.geolocation` as g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix 
WHERE o.order_delivered_customer_date IS NOT NULL 
GROUP BY g.geolocation_state 
)

SELECT 
  State,
  diff_date.date_before_estimated as `Date`
FROM diff_date
WHERE diff_date.date_before_estimated > 0
ORDER BY diff_date.date_before_estimated desc
LIMIT 5
