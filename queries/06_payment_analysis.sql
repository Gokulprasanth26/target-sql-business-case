-- VI. Analysis based on the payments:

-- A. Find the month on month no. of orders placed using different payment types.

-- Hint: We want you to count the no. of orders placed using different payment
-- methods in each month over the past years.

SELECT *
FROM `target.payments`
LIMIT 20

SELECT *
FROM `target.orders`
LIMIT 20

WITH extract_month as 
(SELECT 
  o.order_id,
  p.payment_type,
  EXTRACT(YEAR from o.order_purchase_timestamp) as Year,
  EXTRACT(MONTH from o.order_purchase_timestamp) as Month
FROM `target.payments` as p 
JOIN `target.orders` as o ON p.order_id = o.order_id),
agg as 
(SELECT 
  payment_type,Year,Month,
  COUNT(order_id) as No_of_orders
FROM extract_month
GROUP BY payment_type,Year,Month)

SELECT 
  Year,
  Month,
  payment_type,
  No_of_orders
FROM agg
ORDER BY Year, Month, payment_type

-- B. Find the no. of orders placed on the basis of the payment installments that have
-- been paid.

-- Hint: We want you to count the no. of orders placed based on the no. of
-- payment installments where at least one installment has been successfully paid.

SELECT *
FROM `target.payments`
LIMIT 20

SELECT 
  payment_installments,
  COUNT(order_id) as No_of_orders
FROM `target.payments`
WHERE payment_installments >= 1
GROUP BY payment_installments

