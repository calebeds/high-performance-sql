EXPLAIN SELECT
 first_name,
 last_name,
 email
FROM
 sales.customers
WHERE
 customer_id IN
 (SELECT customer_id
 FROM sales.orders
 WHERE total_amount > (SELECT AVG(total_amount) FROM sales.orders)
 );
 
