## DataLearn [Модуль 2](https://github.com/Data-Learn/data-engineering/blob/master/DE-101%20Modules/Module02/readme.md)
### PostgreSQL, DBeaver
Устанавливаем PostgreSQL, DBeaver, подключаемся к базе Postgres.
Создаём таблицы, загружаем данные с помощью sql запросов [orders](https://github.com/Data-Learn/data-engineering/blob/master/DE-101%20Modules/Module02/DE%20-%20101%20Lab%202.1/orders.sql), [people](https://github.com/Data-Learn/data-engineering/blob/master/DE-101%20Modules/Module02/DE%20-%20101%20Lab%202.1/people.sql), [returns](https://github.com/Data-Learn/data-engineering/blob/master/DE-101%20Modules/Module02/DE%20-%20101%20Lab%202.1/returns.sql).
Копируем, вставляем в DBeaver, выполняем.  
С табличкой returns получаем ошибку: 
  
![alt text](https://github.com/ehperminute/DE-101/blob/main/Module2/returns_error.jpg)
1. Overview (обзор ключевых метрик)
- Total Sales
- Total Profit
- Profit Ratio
- Profit per Order
```sql
SELECT 
	UNNEST(ARRAY['Total Sales', 'Total Profit', 'Profit Ratio', 'Profit per Order', 
		'Sales per Customer', 'Avg. Discount']) AS metric,
	UNNEST(ARRAY[SUM(sales), SUM(profit), ROUND(SUM(profit) / SUM(sales) * 100, 2), SUM(profit) / COUNT(DISTINCT order_id), 
		ROUND(SUM(Sales) / COUNT(DISTINCT customer_id)), ROUND(AVG(discount) * 100, 2)]) AS value
FROM
	orders;
```
- Monthly Sales by Segment
 
```sql
SELECT
	year_month,
	SUM(CASE WHEN segment = 'Consumer' THEN sales ELSE 0 end) AS "Consumer",
	SUM(CASE WHEN segment = 'Corporate' THEN sales ELSE 0 end) AS "Corporate",
	SUM(CASE WHEN segment = 'Home Office' THEN sales ELSE 0 end) AS "Home Office",
	SUM(sales) as total
FROM 
	(SELECT
		sales,
		to_char(order_date, 'YYYY_MM') AS year_month,
		segment
	FROM
		orders)
GROUP BY
	year_month
ORDER BY 
	year_month;
```
- Monthly Sales by Product Category
  
```sql
SELECT 
	date,
	SUM(CASE WHEN category = 'Furniture' THEN sales ELSE 0 end) AS "Furniture",
	SUM(CASE WHEN category = 'Office Supplies' THEN sales ELSE 0 end) AS "Office Supplies",
	SUM(CASE WHEN category = 'Technology' THEN sales ELSE 0 end) AS "Technology",
	SUM(sales) AS total
FROM 
	(SELECT 
	to_char(order_date, 'YYYY-MM') AS "date",
	category,
	sales
FROM orders o
)
GROUP BY "date"
ORDER BY "date"
```

2. Product Dashboard (Продуктовые метрики)
- Sales by Product Category over time (Продажи по категориям)
```sql
SELECT 
	date,
	SUM(CASE WHEN category = 'Furniture' THEN sales ELSE 0 end) AS "Furniture",
	SUM(CASE WHEN category = 'Office Supplies' THEN sales ELSE 0 end) AS "Office Supplies",
	SUM(CASE WHEN category = 'Technology' THEN sales ELSE 0 end) AS "Technology",
	SUM(sales) AS total
FROM 
	(SELECT 
	to_char(order_date, 'YYYY-MM-DD') AS "date",
	category,
	sales
FROM orders o
)
GROUP BY "date"
ORDER BY "date"
```
3. Customer Analysis
- Sales and Profit by Customer
```sql
SELECT 
	customer_id,
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
	orders
GROUP BY
	customer_id;
```
- Customer Ranking
```sql
SELECT 
	customer_id,
	RANK() OVER (ORDER BY SUM(profit) DESC) AS customer_rank,
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
	orders
GROUP BY
	customer_id;
```
- Sales per region
```sql
SELECT 
	region,
	SUM(sales) AS sales
FROM
	orders
GROUP BY
	region;
```

