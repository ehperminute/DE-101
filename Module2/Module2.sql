/*Используя данные Sample - Superstore.xls сделать:

Total Sales
Total Profit
Profit Ratio
Profit per Order
Sales per Customer
Avg. Discount
Monthly Sales by Segment 
Monthly Sales by Product Category
Sales by Product Category over time (Продажи по категориям)
Sales and Profit by Customer
Customer Ranking
Sales per region*/

--Total Sales	
SELECT 
	COUNT(order_id)
FROM
	orders;

--Total Profit
SELECT 
	SUM(profit)
FROM
	orders;

--Profit Ratio	
SELECT 
	SUM(profit) / SUM(sales)
FROM
	orders;

--Profit per Order	
SELECT 
	SUM(profit) / COUNT(order_id)
FROM	
	orders;

--Sales per Customer
SELECT 
	SUM(Sales) / COUNT(customer_id) AS Sales_per_Customer
FROM orders;

--Avg. Discount
SELECT
	AVG(discount)
FROM
	orders;
	
--Monthly Sales by Segment

SELECT
	segment,
	year_month,
	SUM(sales)
FROM 
	(SELECT
		sales,
		to_char(order_date, 'YYYY_MM') AS year_month,
		segment
	FROM
		orders)
GROUP BY
	segment,
	year_month
ORDER BY 
	year_month;
	
--Monthly Sales by Product Category

SELECT
	category,
	year_month,
	SUM(sales)
FROM 
	(SELECT
		sales,
		to_char(order_date, 'YYYY_MM') AS year_month,
		category
	FROM
		orders)
GROUP BY
	category,
	year_month
ORDER BY 
	year_month;
	
--Sales by Product Category over time
SELECT
	DISTINCT category
FROM
	orders;
	
--Sales and Profit by Customer
SELECT 
	customer_id,
	SUM(sales),
	SUM(profit)
FROM
	orders
GROUP BY
	customer_id;
	
--Customer Ranking
SELECT 
	customer_id,
	RANK() OVER (ORDER BY SUM(profit) DESC),
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
	orders
GROUP BY
	customer_id;
	
--Sales per region
SELECT 
	region,
	SUM(sales)
FROM
	orders
GROUP BY
	region;
