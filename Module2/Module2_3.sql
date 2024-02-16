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


SELECT 
	UNNEST(ARRAY['Total Sales', 'Total Profit', 'Profit Ratio', 'Profit per Order', 
		'Sales per Customer', 'Avg. Discount']) AS metric,
	UNNEST(ARRAY[SUM(sales), SUM(profit), ROUND(SUM(profit) / SUM(sales) * 100, 2), SUM(profit) / COUNT(DISTINCT order_id), 
		ROUND(SUM(Sales) / COUNT(DISTINCT customer_id)), ROUND(AVG(discount) * 100, 2)]) AS value
FROM
	orders;



-----------------------------------------
/*
--Total Sales	
SELECT 
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
FROM
	orders;

--Total Profit
SELECT 
	
FROM
	orders;

--Profit Ratio	
SELECT 
	SUM(profit) / SUM(sales) AS profit_ratio
FROM
	orders;

--Profit per Order	
SELECT 
	SUM(profit) / COUNT(DISTINCT order_id)
FROM	
	orders;

--Sales per Customer
SELECT 
	SUM(Sales) / COUNT(DISTINCT customer_id) AS Sales_per_Customer
FROM orders;

--Avg. Discount
SELECT
	AVG(discount)
FROM
	orders;*/
	
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
	SUM(sales) AS sales
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
	category, year_month;
	
--Sales by Product Category over time
SELECT
	DISTINCT category
FROM
	orders;
	
--Sales and Profit by Customer
SELECT 
	customer_id,
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
	orders
GROUP BY
	customer_id;
	
--Customer Ranking
SELECT 
	customer_id,
	RANK() OVER (ORDER BY SUM(profit) DESC) AS customer_rank,
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
	orders
GROUP BY
	customer_id;
	
--Sales per region
SELECT 
	region,
	SUM(sales) AS sales
FROM
	orders
GROUP BY
	region;