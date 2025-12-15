CREATE TABLE customer
(customer_id INT, customer_name VARCHAR(50), segment VARCHAR(50), age INT, 
country VARCHAR(50), city VARCHAR(20),
state VARCHAR(20), post_code INT, region VARCHAR(30));

SELECT * FROM customer;

ALTER TABLE customer ADD PRIMARY KEY(customer_id;

ALTER TABLE customer ALTER customer_id TYPE VARCHAR(20);

COPY customer FROM 'C:\Program Files\PostgreSQL\17\data\CLARISSA\Customer.CSV'
DELIMITER ',' CSV HEADER;



CREATE TABLE product
(product_id VARCHAR(50), category VARCHAR(50), sub_category VARCHAR(50),
product_name VARCHAR(120));
ALTER TABLE product ADD PRIMARY KEY(product_id);

SELECT * FROM product;
ALTER TABLE product ALTER product_name TYPE VARCHAR(255);

COPY product FROM 'C:\Program Files\PostgreSQL\17\data\CLARISSA\Product.CSV'
DELIMITER ',' CSV HEADER;

CREATE TABLE sales
(order_line INT PRIMARY KEY,order_id VARCHAR(50), order_date DATE, ship_date DATE, 
ship_mode VARCHAR(60), customer_id VARCHAR(50),product_id VARCHAR(60),sales NUMERIC,
quantity INT, discount DECIMAL, profit NUMERIC);

SELECT * FROM sales;

COPY sales FROM 'C:\Program Files\PostgreSQL\17\data\CLARISSA\Sales.CSV'
DELIMITER ',' CSV HEADER;

SELECT * FROM customer;
SELECT  region, COUNT(customer_id) AS no_of_customers FROM customer
GROUP BY region ORDER BY COUNT(customer_id) DESC;

SELECT region, COUNT(city) AS no_of_cities FROM customer
GROUP BY region ORDER BY COUNT (city) DESC;

SELECT COUNT(customer_id) AS"customer older than 60" FROM customer WHERE age < 60;

SELECT COUNT (distinct city) FROM customer;
SELECT MIN(age) FROM customer;

SELECT MAX(age)FROM customer;
SELECT customer_name, MAX(age) FROM customer GROUP BY customer_name;


SELECT COUNT(customer_id) AS "No_ of_customers except from LA" 
FROM customer WHERE NOT city = 'Los Angeles';


SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM sales;

SELECT c.customer_name, c.state, s.order_date, s.profit
FROM customer AS c
LEFT JOIN sales AS s
ON c.customer_id = s.customer_id;

SELECT p.category, p.product_name,s.sales
FROM product AS p
LEFT JOIN sales AS s
ON p.product_id = s.product_id;

SELECT c.region, CEIL (SUM (s.sales)) AS "sales"
FROM customer AS c
JOIN sales AS s
ON c.customer_id =s.customer_id
GROUP BY region;

SELECT c.customer_name, SUM(s.sales)
FROM customer AS c
JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY SUM(s.sales) DESC LIMIT 5;

ALTER TABLE customer ADD age_group VARCHAR(50);
UPDATE customer SET age_group = 'senior citizen' WHERE age >= 60;
UPDATE customer SET age_group = 'middle age' WHERE age >25;
UPDATE customer SET  age_group = 'young' WHERE age <= 25;

ALTER TABLE customer ADD age_group VARCHAR(50);
UPDATE customer SET age_group = case
WHERE age > 60 THEN 'senior citizen' 
WHERE age > 25 THEN 'middle age'
ELSE 'young'
END;

SELECT "customer_name", age, age_group FROM customer;

SELECT age_group, COUNT(age_group) AS "no of customer"
FROM customer 
GROUP BY age_group 
ORDER BY "no of customer" DESC;

SELECT c.region, s.sales
FROM  customer c
JOIN sales s
ON c.customer_id = s.customer_id;


SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM sales;

SELECT DISTINCT region FROM customer ORDER BY region;
SELECT DISTINCT region FROM customer;


SELECT * FROM customer WHERE state = 'Kentucky'OR state =
'California' OR state = 'Florida'
OR state = 'North Caroline';

SELECT * FROM customer 
WHERE state IN ('Kentucky', 'California', 'Florida', 'North Caroline');

SELECT * FROM customer
WHERE region IN ('Central', 'East', 'South'); 

SELECT * FROM customer WHERE age >30 AND age <50;

SELECT * FROM customer 
WHERE age BETWEEN 30 AND 60;

SELECT region, COUNT(*) FROM customer WHERE region IN ('Central', 'East', 'South')
GROUP BY region;


SELECT region, COUNT(customer_name)
FROM customer GROUP BY region 
HAVING region IN ('Central', 'East','South');

SELECT *FROM customer
WHERE customer_name LIKE 'A%';


SELECT *FROM customer
WHERE customer_name LIKE 'A% A%';

SELECT *FROM customer
WHERE customer_name LIKE '%A____';

SELECT c.customer_name, c.age, CEIL(SUM(s.sales))
FROM customer AS c
LEFT JOIN sales AS s
ON c.customer_id = s.customer_id
WHERE age >60 
GROUP BY c.customer_name, c.age
ORDER BY SUM(s.sales) DESC;

SELECT p.product_name,CEIL(SUM(s.sales))
FROM product AS p
LEFT JOIN sales AS s
ON p.product_id = s.product_id
GROUP BY product_name 
ORDER BY SUM(s.sales) DESC LIMIT 5;

SELECT c.segment,ROUND(SUM(s.sales),2)
FROM customer AS c
LEFT JOIN sales AS s
ON c.customer_id = s.customer_id
GROUP BY segment 
ORDER BY SUM(s.sales)DESC;

