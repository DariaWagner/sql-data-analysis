-- KPI queries for data analysis
-- Tables used (example): customers, orders

-- 1. Customers per country
SELECT
    c.country,
    COUNT(*) AS total_customers
FROM customers c
GROUP BY country
ORDER BY total_customers DESC;

-- 2. Orders per country
SELECT
    c.country,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_orders DESC;

-- 3. Order per customer (ranking)
SELECT
    c.customer_id,
    COUNT(o.order_id) AS orders_per_customer
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY orders_per_customer DESC;

-- 4. Active vs Inactive Customers (customers with at least one order)
SELECT
    CASE 
        WHEN o.order_id IS NULL THEN 'inactive'
        ELSE 'active'
    END AS customer_status,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    CASE
        WHEN o.order_id IS NULL THEN 'inactive'
        ELSE 'active'
    END;
ORDER BY total_customers DESC;