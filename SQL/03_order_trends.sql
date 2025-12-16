-- III. Evolution of E-commerce orders in the Brazil region:
-- A. Get the month on month no. of orders placed in each state.
-- Hint: We want you to get the no. of orders placed in each state, in each month
-- by our customers.

SELECT *
FROM `target.orders`
LIMIT 20

SELECT *
FROM `target.customers`
LIMIT 20

SELECT *
FROM `target.geolocation`
LIMIT 20

SELECT
  c.customer_id as Customer_id,
  EXTRACT(YEAR FROM o.order_purchase_timestamp) as Year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) as Month,
  g.geolocation_state as state,
  COUNT(o.order_id) as No_of_orders
FROM `target.orders` as o
JOIN `target.customers` as c ON o.customer_id = c.customer_id  
JOIN `target.geolocation` as g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY Customer_id,Year,Month,state
ORDER BY Year,Month,state

-- B. How are the customers distributed across all the states?
-- Hint: We want you to get the no. of unique customers present in each state.

SELECT *
FROM `target.customers`
LIMIT 20

SELECT 
  customer_state,
  COUNT(DISTINCT customer_id) as No_of_unique_customer
FROM `target.customers`
GROUP BY customer_state
ORDER BY customer_state,No_of_unique_customer 
