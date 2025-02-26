EXPLAIN WITH high_value_customers AS (
 SELECT 
  customer_id
 FROM
  sales.orders
 WHERE
  order_date > '2024-07-01'
 GROUP BY customer_id
 HAVING
  SUM(total_amount) > 1000 
)
SELECT
 c.first_name,
 c.last_name,
 c.email
FROM
 sales.customers c
JOIN
 high_value_customers hvc
ON 
 c.customer_id = hvc.customer_id
