# ☕ Coffee Shop Sales Analysis

## 📊 Overview

This project analyzes transactional sales data from a coffee shop to uncover key business insights related to revenue, product performance, store performance, and customer purchasing patterns.

The goal is to transform raw data into meaningful insights that can support better business decisions.

---

## 🧠 Business Problem

The business wants to better understand its performance by answering the following questions:

* Which store location generates the most revenue?
* What are the busiest times of the day?
* Which products perform the best and worst?
* How can sales patterns help improve business strategy?

---

## 🛠️ Tools & Technologies

* **SQL (Google BigQuery)** – Data querying and analysis
* **Powerpoint** – Presentation creation 
* **Excel** – Data exploration and pivot tables
* **Miro** – Planning and structuring analysis
* **AI Tools (e.g., Lovable)** – Supporting dashboard design and workflow

---

## 📂 Dataset

The dataset includes the following fields:

* transaction_id
* transaction_date
* transaction_time
* transaction_qty
* store_id
* store_location
* product_id
* unit_price
* product_category
* product_type
* product_detail

A calculated field was created:

* **Revenue = transaction_qty × unit_price**

---

## 🔍 Analysis Performed

### 1. Revenue Analysis

Calculated total revenue across all transactions to measure overall business performance.

### 2. Store Performance

Compared revenue across different store locations to identify the top-performing branch.

### 3. Peak Hours Analysis

Analyzed transaction times to determine the busiest hours of the day.

### 4. Product Performance

Ranked products based on revenue to identify best-selling and lowest-performing items.

### 5. Sales Trends

Reviewed patterns in sales to understand customer behavior and peak activity periods.

---

## 📈 Key Insights

* **Hell’s Kitchen** generated the highest revenue among all store locations.
* The busiest sales period occurs between **8 AM and 10 AM**, indicating strong morning demand.
* The top-performing product was **Sustainability Grown Organic (Large)**.
* The lowest-performing product was **Dark Chocolate**, suggesting low customer demand.
* Morning hours are a key revenue driver and should be prioritized in operations and staffing.

---

## 💻 Example SQL Queries

### Total Revenue by Store Location

```sql
SELECT 
    store_location,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY store_location
ORDER BY total_revenue DESC;
```

### Busiest Hours

```sql
SELECT 
    EXTRACT(HOUR FROM transaction_time) AS sale_hour,
    COUNT(*) AS total_transactions
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY sale_hour
ORDER BY total_transactions DESC;
```

### Top Products by Revenue

```sql
SELECT 
    product_detail,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY product_detail
ORDER BY revenue DESC;
```

---


## 📚 What I Learned

* Writing SQL queries for real-world datasets using BigQuery
* Performing data aggregation and grouping for insights
* Identifying business trends from raw data
* Building dashboards to communicate findings clearly
* Connecting data analysis to real business decisions

---

## 🚀 Future Improvements

* Add monthly and yearly trend analysis
* Perform deeper product category analysis
* Include customer segmentation if data becomes available
* Enhance dashboard interactivity

---

## 📌 Conclusion

This project demonstrates how data analysis can be used to uncover actionable insights and support business decision-making in a retail environment.

---

⭐ *This project reflects my growing skills in SQL, data analysis, and business intelligence.*
