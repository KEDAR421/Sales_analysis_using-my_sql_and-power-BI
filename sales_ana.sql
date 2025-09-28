CREATE DATABASE pizza_sale_analysis_DB;
use pizza_sale_analysis_DB;
select * from pizza_sales;

SET SQL_SAFE_UPDATES = 0;

## --data cleaning--- 
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
ALTER TABLE pizza_sales
    MODIFY COLUMN pizza_id INT NOT NULL,
    MODIFY COLUMN order_id INT NOT NULL,
    MODIFY COLUMN pizza_name_id VARCHAR(50) NOT NULL,
    MODIFY COLUMN quantity TINYINT NOT NULL,
    MODIFY COLUMN order_date DATE NOT NULL,
    MODIFY COLUMN order_time TIME NOT NULL,
    MODIFY COLUMN unit_price FLOAT NOT NULL,
    MODIFY COLUMN total_price FLOAT NOT NULL,
    MODIFY COLUMN pizza_size VARCHAR(50) NOT NULL,
    MODIFY COLUMN pizza_category VARCHAR(50) NOT NULL,
    MODIFY COLUMN pizza_ingredients VARCHAR(200) NOT NULL,
    MODIFY COLUMN pizza_name VARCHAR(50) NOT NULL;

##--Exploratory Data Analysis---

##--Total number of Pizzas Sold----
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

##--  Total Revenue---
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

##--Average Order Value---
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

##--Total numbers of Orders---
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

##--Average Pizzas Per Order---
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

##---Daily Trend for Total Orders---
SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)
LIMIT 0, 1000;

##---Monthly Trend for Orders---
SELECT 
    MONTHNAME(order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
LIMIT 0, 1000;

##--% of Sales by Pizza Category---
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

##--% of Sales by Pizza Size--
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

##--Total Pizzas Sold by Pizza Category--
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

##--Top 5 Pizzas by Revenue--
SELECT 
    pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

##-- Bottom 5 Pizzas by Revenue--
SELECT 
    pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

#--Top 5 Pizzas by Quantity--
SELECT 
    pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

#--Bottom 5 Pizzas by Quantity--
SELECT 
    pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

#--Top 5 Pizzas by Total Orders--
SELECT 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

##--Borrom 5 Pizzas by Total Orders--
SELECT 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

##---Top 5 order pizas--
SELECT 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

##--top 5 orders from bottom--
SELECT 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;



describe pizza_sales;