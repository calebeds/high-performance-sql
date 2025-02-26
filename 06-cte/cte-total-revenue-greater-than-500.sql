EXPLAIN WITH order_summary AS (
 SELECT 
  o.order_id,
  o.customer_id,
  o.order_date,
  SUM(oi.quantity) AS total_items,
  SUM(oi.subtotal) AS order_total
 FROM
  sales.orders o
 JOIN
  sales.order_items oi
 ON 
  o.order_id = oi.order_id
 GROUP BY
  o.order_id, o.customer_id, o.order_date
)
SELECT
 order_id,
 order_date,
 total_items,
 order_total
FROM
 order_summary
WHERE
 order_total > 500
ORDER BY
 order_date DESC
