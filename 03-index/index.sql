CREATE INDEX idx_customer_last_names ON sales.customers(last_name);
CREATE INDEX idx_customer_state ON sales.customers(state);
CREATE INDEX idx_customer_country ON sales.customers(country);

CREATE INDEX idx_orders_order_date ON sales.orders(order_date);
CREATE INDEX idx_orders_total_amount ON sales.orders(total_amount);
CREATE INDEX idx_orders_customer_id ON sales.orders(customer_id);

CREATE INDEX idx_order_items_order_id ON sales.order_items(order_id);
CREATE INDEX idx_order_items_product_id ON sales.order_items(product_id);

CREATE INDEX idx_products_name ON sales.products(name);
CREATE INDEX idx_proudcts_price ON sales.products(price);

-- indices are more likely to be used in highly selective queries like so:

 EXPLAIN SELECT
 order_id,
 customer_id,
 order_date,
 total_amount
FROM
 sales.orders
WHERE
 total_amount > 1400
ORDER BY
 total_amount DESC;

-- in the database we were using, this query only retrieve two rows, so is highly selective
-- good to keep in mind that that's not always the case. Sometimes in small database index are not used even in highly selective query




-- one of the tables is going to use index
EXPLAIN SELECT
 o.order_id,
 o.order_date,
 o.total_amount,
 c.first_name,
 c.last_name,
 c.state
FROM
 sales.orders o
JOIN
 sales.customers c
ON
 o.customer_id = c.customer_id
WHERE
 o.total_amount > 100
AND
 c.state = 'Massachusetts's
