SET enable_hashjoin = off;
SET enable_mergejoin = off;
SET enable_nestloop = on;

EXPLAIN SELECT 
 c.customer_id,
 c.first_name,
 c.last_name,
 c.country,
 o.order_id,
 o.order_date
FROM
 sales.customers c
JOIN
 sales.orders o
ON
 c.customer_id = o.customer_id
WHERE
 o.customer_id BETWEEN 100 AND 200
ORDER BY
 o.customer_id, o.order_date 
