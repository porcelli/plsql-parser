SELECT *
FROM   (SELECT product_code, quantity
        FROM   pivot_test)
PIVOT  (SUM(quantity) AS sum_quantity FOR (product_code) IN ('A' AS a, 'B' AS b, 'C' AS c));
