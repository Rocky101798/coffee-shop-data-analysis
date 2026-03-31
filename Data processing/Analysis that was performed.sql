--This to to check if the table has been loaded correctly
SELECT * FROM studies101.brightlearn.bright_coffee_shop_analysis
LIMIT 20;

--This is when they started collecting their data 
SELECT MIN(transaction_date) AS first_date 
FROM studies101.brightlearn.bright_coffee_shop_analysis;

--The last time they collected the data 
SELECT MAX(transaction_date) AS Last_date 
FROM studies101.brightlearn.bright_coffee_shop_analysis;

--This is to check how many stores there are 
SELECT DISTINCT store_location 
FROM studies101.brightlearn.bright_coffee_shop_analysis;

--This is to show the number of stores
SELECT COUNT(DISTINCT store_id) AS number_of_stores 
FROM studies101.brightlearn.bright_coffee_shop_analysis;

---This shows us all the products they sell across all the stores
SELECT DISTINCT product_category 
FROM studies101.brightlearn.bright_coffee_shop_analysis;

---- This is to show the total amounts per row
SELECT 
    transaction_id,
    transaction_date,
    transaction_qty,
    store_location,
    product_category,
    product_type,
    unit_price,
    ROUND(transaction_qty * unit_price, 2) AS total_amount
FROM studies101.brightlearn.bright_coffee_shop_sales
LIMIT 20;

--This is to see revenue per day as well as the day of the week and month of the year.
SELECT transaction_id,
        transaction_date,
        DATE_FORMAT(transaction_date, 'EEEE') AS day_of_week, 
        DATE_FORMAT(transaction_date, 'MMMM') AS name_of_month, 
        ROUND(transaction_qty * unit_price, 2) AS total_amounts
FROM studies101.brightlearn.bright_coffee_shop_analysis;

---This is to show how many transactions each store has done, use GROUP BY whenever theres an aggregate function 
SELECT store_location,
       COUNT(transaction_id) AS total_transactions  
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY store_location
ORDER BY total_transactions DESC;

--calculating the revenue
SELECT unit_price,
        transaction_qty,
        unit_price* transaction_qty AS REVENUE
FROM studies101.brightlearn.bright_coffee_shop_analysis;


--This one shows you the unique types of product for each category 
SELECT product_category,
      COUNT(transaction_id) AS total_transactions, 
      COUNT(DISTINCT product_type) AS unique_products
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY product_category
ORDER BY  total_transactions DESC;

--This shows us the min and max price for each category as well as the average price (price range)
SELECT product_category,
      MIN(unit_price) AS min_price,
      MAX(unit_price) AS max_price,
      ROUND(AVG(unit_price),2) AS average_price
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY product_category;

--This would show us the timeframe in which we are working with 
SELECT MIN(transaction_date) AS first_date,
        MAX(transaction_date) AS last_date,
        COUNT(DISTINCT transaction_date) AS total_days,
        COUNT(transaction_id) AS total_transactions
FROM studies101.brightlearn.bright_coffee_shop_analysis;


--This is to check if there are any null values in the table
SELECT
    COUNT(transaction_id) AS total_rows,
    COUNT(CASE WHEN transaction_id IS NULL THEN 1 END) AS null_transaction_id,
    COUNT(CASE WHEN transaction_date IS NULL THEN 1 END) AS null_transaction_date,
    COUNT(CASE WHEN transaction_time IS NULL THEN 1 END) AS null_transaction_time,
    COUNT(CASE WHEN transaction_qty IS NULL THEN 1 END) AS null_transaction_qty,
    COUNT(CASE WHEN store_location IS NULL THEN 1 END) AS null_store_location,
    COUNT(CASE WHEN unit_price IS NULL THEN 1 END) AS null_unit_price,
    COUNT(CASE WHEN product_category IS NULL THEN 1 END) AS null_product_category,
    COUNT(CASE WHEN product_type IS NULL THEN 1 END) AS null_product_type,
    COUNT(CASE WHEN product_detail IS NULL THEN 1 END) AS null_product_detail
FROM studies101.brightlearn.bright_coffee_shop_analysis;

---This was for me to label the transaction_time. i had to change the format of the time column because it was mixed with the date as well and i used a subquery.
SELECT *,
   CASE WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '07:00' THEN '06:00 - 07:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '08:00' THEN '07:00 - 08:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '09:00' THEN '08:00 - 09:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '10:00' THEN '09:00 - 10:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '11:00' THEN '10:00 - 11:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '12:00' THEN '11:00 - 12:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '13:00' THEN '12:00 - 13:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '14:00' THEN '13:00 - 14:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '15:00' THEN '14:00 - 15:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '16:00' THEN '15:00 - 16:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '17:00' THEN '16:00 - 17:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '18:00' THEN '17:00 - 18:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '19:00' THEN '18:00 - 19:00'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') < '20:00' THEN '19:00 - 20:00'
        ELSE '20:00 - Close'
        END AS Transaction_time_bucket 
FROM(
SELECT transaction_id,
            transaction_date,
            transaction_time,
            transaction_qty,
            store_location,
            unit_price,
            product_category,
            product_type,
            product_detail,
            ROUND(transaction_qty * unit_price, 2) AS total_amounts 
FROM studies101.brightlearn.bright_coffee_shop_analysis
ORDER BY transaction_date,
        transaction_time
);

-- This is to see the busiest day and how much we made on each day of the week  
SELECT transaction_date, 
    DATE_FORMAT(TO_DATE(transaction_date, 'M/d/yyyy'), 'EEEE') AS day_of_week,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM studies101.brightlearn.bright_coffee_shop_analysis
GROUP BY transaction_date, 
        day_of_week
ORDER BY total_transactions  DESC;

--This is to show the busiest months according to transactions 
SELECT 
    DATE_FORMAT(TO_DATE(transaction_date, 'M/d/yyyy'), 'MMMM') AS month_name,
    MONTH(TO_DATE(transaction_date, 'M/d/yyyy')) AS month_number,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM studies101.brightlearn.bright_coffee_shop_sales
GROUP BY month_name, month_number
ORDER BY total_transactions DESC
LIMIT 5;


--this is just showing us when each transaction had happened
SELECT transaction_date,
        product_category,
        product_type,
        DATE_FORMAT(transaction_time, 'HH:MM') AS timeframe
FROM studies101.brightlearn.bright_coffee_shop_analysis
ORDER BY transaction_time;
