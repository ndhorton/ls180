SELECT c.name, SUM(oi.quantity * oi.price_per_unit) AS total_spending
  FROM customers AS c
       LEFT OUTER JOIN orders AS o
       ON c.id = o.customer_id
       LEFT OUTER JOIN order_items AS oi
       ON o.id = oi.order_id
 WHERE o.order_date >= '2023-01-01'
       AND o.order_date < '2023-07-01'
 GROUP BY c.id, c.name
 ORDER BY total_spending DESC
 LIMIT 3;

