CREATE INDEX idx_lastname_reverse ON sales.customers(REVERSE(last_name));

SELECT
 customer_id,
 first_name,
 last_name,
 email
FROM
 sales.customers
WHERE
 REVERSE(last_name) LIKE REVERSE('son') || '%';
