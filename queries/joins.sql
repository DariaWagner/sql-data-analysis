-- JOIN examples for data analysis

SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.country
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id;

SELECT
    c.country,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_orders DESC;