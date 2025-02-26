EXPLAIN ANALYSE SELECT first_name, last_name
FROM sales.customers
WHERE customer_id IN (
	SELECT customer_id
	FROM sales.orders
	WHERE order_id IN (
		SELECT product_id
		FROM sales.products
		ORDER BY price DESC
		LIMIT 1
	)
);



EXPLAIN ANALYSE WITH most_expensive_product AS (
	SELECT product_id
	FROM sales.products
	ORDER BY price DESC
	LIMIT 1
),
orders_with_expensive_product AS (
	SELECT DISTINCT order_id
	FROM sales.order_items
	WHERE product_id = (SELECT product_id FROM most_expensive_product)
),
customers_with_expensive_orders AS (
	SELECT DISTINCT customer_id
	FROM sales.orders
	WHERE order_id IN (SELECT order_id FROM orders_with_expensive_product)
)
SELECT first_name, last_name
FROM sales.customers
WHERE customer_id IN (SELECT customer_id FROM customers_with_expensive_orders);

EXPLAIN ANALYSE SELECT DISTINCT c.first_name, c.last_name
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN(
	SELECT product_id
	FROM sales.products
	ORDER BY price DESC
	LIMIT 1
) p ON oi.product_id = p.product_id;
