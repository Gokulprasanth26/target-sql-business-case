/*
Project: Target SQL Business Case
Database: BigQuery
Author: Gokul Prasanth B
Description: Exploratory analysis on Target e-commerce dataset
*/

-- I. Import the dataset and do usual exploratory analysis steps like checking the
-- structure & characteristics of the dataset.

-- A. Data type of all columns in the “customers”
-- Hint: We want you to display the data type of each column present in the
-- “customers” table.

SELECT 
  table_name,
  column_name,
  data_type
FROM `target-sql-471608.target.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name='customers'

-- B. Get the time range between which the orders were placed.
-- Hint: We want you to get the date & time when the first and last orders in our
-- dataset were placed.

SELECT *
FROM `target.orders`
LIMIT 20

SELECT 
  MIN(DATE(order_purchase_timestamp)) as first_order_date,
  MAX(DATE(order_purchase_timestamp)) as last_order_date
FROM `target.orders`

-- C. Count the number of Cities and States in our dataset
-- Hint: We want you to count the number of unique cities and states present in
-- our dataset.

SELECT *
FROM `target.geolocation`
LIMIT 20

SELECT
  COUNT(DISTINCT(geolocation_city)) as unique_city,
  COUNT(DISTINCT(geolocation_state)) as unique_state
FROM `target.geolocation`
