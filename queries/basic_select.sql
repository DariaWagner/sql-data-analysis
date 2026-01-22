-- Basic SELECT queries for data analysis

SELECT *
FROM customers;

SELECT customer_id, country
FROM customers
WHERE country = 'Germany';

SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;