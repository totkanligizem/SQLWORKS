--tabloya yeni bir kayıt ekemek için ınsert komutu kullanılır
--kallani şekli Insert info <tabloadi> (kolon1,kolo2,....)values (deger1,değer2.....)
INSERT INTO shippers(shipper_id,company_name,phone) VALUES (7,'Mng kargo','444 0 333')
SELECT * FROM shippers

--kendinizi employees tablosuna kayıt edin 

INSERT INTO employees (employee_id,last_name,first_name ) VALUES (11,'gün','kaan');

SELECT * FROM employees
SELECT * FROM orders
SELECT * FROM products
SELECT * FROM customers

--10 adet çay,1 kg mozeralla peyniri , 5 adet de Ikura 


INSERT INTO orders (order_id,customer_id,employee_id,order_date,required_date,shipped_date,ship_via,ship_city,ship_country)
VALUES(11078,'ALFKI',11,NULL,'2024-09-10','2024-09-01',3,'Berlin','Germany')

SELECT * from orders where employee_id=11

INSERT INTO order_details (order_id,product_id,unit_price,quantity,discount)
VALUES(11078,1,20,20,0) --Çay için oluşturulan kayıt

INSERT INTO order_details (order_id,product_id,unit_price,quantity,discount)
VALUES(11078,72,40,2,0) --Mozarella

INSERT INTO order_details (order_id,product_id,unit_price,quantity,discount)
VALUES(11078,10,40,5,0) --IKURA 

select * from order_details where order_id=11078

SELECT * FROM shippers

UPDATE shippers set phone ='444 0 444' WHERE shippers.shipper_id=6

SELECT * FROM employees

update employees set birth_date ='02.09.1999' WHERE employees.employee_id=11

SELECT * FROM orders WHERE orders.order_id=10248 AND products.product_id = 11

UPDATE order_date set unit_price=5.45,discount=0.20,quantity=3.5 WHERE orders.customer_id=10238 AND products.product_id =11


CREATE TABLE yedekorder AS
SELECT * 
FROM orders 
WHERE EXTRACT(YEAR FROM orders.order_date) = 1996;

DELETE FROM yedekorder
WHERE EXTRACT(MONTH FROM order_date) = 7;


SELECT * FROM yedekorder