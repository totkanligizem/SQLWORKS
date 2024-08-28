-- tek satırlık yorum
/*
çok sayılı yorum
select komutu: Tablo uzerinde sorgulama yapmaya yarar
genel kullanımı Select* from <tablo adı>
*/

select 3+5; --normal aritmetik işlem yapılabilir
select 'bu gün günlerden çarşmaba ';
/*
select * from Customers
select * from shippers
select * from Employees
select * from Categories
*/

SELECT Company_name as ŞirketAdi, address Adres, city 
FROM Customers;

--Alias verme (takma isim)

--belirli şartlara uyan kayıtları bulma 
--Almanyadaki müşterilerin listesi
select * from Customers where Country = 'Germany'

-- almanyadaki berlindeki müşterilenin listesi 

select * from Customers where Country = 'Germany' AND City='Berlin'

SELECT * FROM products;
Select * FROM suppliers;
SELECT * FROM categories;

--
SELECT *FROM products WHERE category_id=1

SELECT *FROM orders
