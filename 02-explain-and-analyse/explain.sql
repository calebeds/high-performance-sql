EXPLAIN ANALYSE SELECT 
  name, description
FROM 
  sales.products
WHERE
  product_id < 20

EXPLAIN SELECT
 product_id,
 quantity
FROM
 sales.order_items
WHERE
 quantity > 5

EXPLAIN ANALYSE SELECT
 product_id,
 quantity
FROM
 sales.order_items
WHERE
 quantity > 5

EXPLAIN ANALYSE SELECT
 product_id,
 SUM(quantity)
FROM
 sales.order_items
GROUP BY
 product_id


EXPLAIN SELECT
 product_id,
 SUM(quantity) as qty
FROM
 sales.order_items
GROUP BY
 product_id
ORDER BY
  qty DESC


EXPLAIN SELECT
 product_id,
 SUM(quantity) as qty,
 count(*) as count_order_items
FROM
 sales.order_items
GROUP BY
 product_id
HAVING
 sum(quantity) > 100
ORDER BY
  qty DESC
