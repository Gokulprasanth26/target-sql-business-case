# Target SQL Business Case Analysis

## 📌 Project Overview
This project analyzes Target’s e-commerce data using SQL to uncover trends related to customer behavior, order growth, payments, freight, and delivery performance.

## 🗂 Dataset
- Source: Target e-commerce business case dataset
- Database: BigQuery
- Tables used:
  - customers
  - orders
  - order_items
  - payments
  - sellers
  - geolocation

## 🛠 Tools & Technologies
- SQL (BigQuery)
- Git & GitHub

## 📊 Business Questions Answered
- What is the time range of orders in the dataset?
- Is there a growing trend in the number of orders over the years?
- Are there seasonal patterns in monthly order volume?
- Which states generate higher order value and freight cost?
- How does actual delivery time compare with estimated delivery time?
- What payment methods are most commonly used?

## 📈 Key Insights
- Order volume shows a consistent growth trend over the years
- Clear monthly seasonality is observed in customer purchases
- Certain states contribute disproportionately to revenue and freight cost
- Orders are often delivered earlier than the estimated delivery date
- Credit card payments dominate over other payment types

## 🧠 SQL Concepts Used
- Joins
- Common Table Expressions (CTEs)
- Aggregations
- Date & Time functions
- Conditional logic (CASE WHEN)
- Pivot tables


## 📌 Notes
- Geolocation table contains duplicate zip code entries; results are aggregated accordingly
- This project focuses on analytical SQL rather than data modeling
