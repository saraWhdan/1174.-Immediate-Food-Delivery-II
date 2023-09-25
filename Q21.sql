SELECT ROUND( AVG(CAST(immediate AS DECIMAL(10, 2))),4) * 100 AS immediate_percentage
FROM (
  SELECT *,
    RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS ranking_order,
    CASE WHEN order_date = customer_pref_delivery_date THEN 1.0 ELSE 0 END AS immediate
  FROM delivery
) AS subquery
where ranking_order=1
