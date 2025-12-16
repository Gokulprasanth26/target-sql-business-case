# 🎯 Target E-Commerce SQL Business Case Analysis

## 📌 Project Overview
This project analyzes Target’s e-commerce data using SQL to uncover insights related to
customer behavior, order growth, logistics performance, and payment patterns.
The objective is to answer real-world business questions and provide actionable
recommendations based on data.

---

## 🗂 Dataset
- **Source:** Target e-commerce business case dataset
- **Database:** Google BigQuery
- **Time Period:** Multi-year historical order data
- **Tables Used:**
  - customers
  - orders
  - order_items
  - payments
  - sellers
  - geolocation

---

## 🛠 Tools & Technologies
- SQL (BigQuery)
- Git & GitHub

---

## 📊 Business Questions Answered
- What is the overall time range of orders in the dataset?
- How has the number of orders changed over the years?
- Are there seasonal trends in monthly order volume?
- Which states generate the highest order value and freight cost?
- How does actual delivery time compare to estimated delivery time?
- What payment methods are most frequently used by customers?

---

## 📈 Key Insights
- Order volume demonstrates a **consistent upward growth trend** over the years
- **Strong monthly seasonality** is observed in customer purchasing behavior
- A small number of states contribute **disproportionately to total revenue and freight costs**
- Most orders are delivered **earlier than the estimated delivery date**
- **Credit cards** are the dominant payment method across transactions

---

## 🧠 SQL Concepts Used
- Joins (INNER, LEFT)
- Common Table Expressions (CTEs)
- Aggregations & Grouping
- Date & Time functions
- Conditional logic using `CASE WHEN`
- Pivot-style analysis

---

## 💡 Business Recommendations
- Improve logistics operations in states with recurring delivery delays
- Focus marketing and retention strategies on high-revenue states
- Optimize freight costs by reviewing seller distribution in high-cost regions

---

## 📌 Notes
- The geolocation table contains duplicate zip code entries; data was aggregated accordingly
- This project focuses on **analytical SQL** rather than data modeling or ETL pipelines
