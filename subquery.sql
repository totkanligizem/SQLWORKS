SELECT * from products
SELECT* FROM orders LIMIT 10;
SELECT * FROM order_details LIMIT 10

SELECT * from products WHERE products.product_id not in (SELECT products.product_id FROM order_details)

select * FROM customers WHERE customers.customer_id not in (SELECT customers.customer_id FROM orders)

SELECT 
    orders.order_id,
    (SELECT customers.company_name FROM customers WHERE customers.customer_id = orders.customer_id) AS Musteri,
    (SELECT first_name || ' ' || last_name FROM employees WHERE employees.employee_id = orders.employee_id) AS calisan
FROM 
    orders;
