EXPLAIN WITH order_locations AS (
 SELECT 
  shipping_state,
  shipping_country,
  COUNT(order_id) AS order_count,
  SUM(total_amount) AS region_revenue
 FROM
  sales.orders
 GROUP BY 
  shipping_state, shipping_country
),
customer_locations AS (
 SELECT 
  state, 
  country,
  COUNT(customer_id) as customer_count
 FROM
  sales.customers
 GROUP BY
  state, country
)
SELECT 
 cl.state,
 cl.country,
 cl.customer_count,
 ol.order_count,
 ol.region_revenue,
 ol.region_revenue / cl.customer_count AS revenue_per_customer
FROM 
 customer_locations cl
JOIN
 order_locations ol
ON 
 cl.state = ol.shipping_state
AND
 cl.country = ol.shipping_country
ORDER BY
 revenue_per_customer DESC

