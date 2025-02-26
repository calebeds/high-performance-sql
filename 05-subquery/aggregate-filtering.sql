EXPLAIN SELECT
 first_name,
 last_name,
 email
FROM
 sales.customers
WHERE customer_id IN (
	SELECT customer_id
	FROM sales.orders
	GROUP BY customer_id
	HAVING SUM(total_amount) > 1000
);
