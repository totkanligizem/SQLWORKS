--Aggragete Fonksiyonlar (Toplam fonksiyonlari,gruplama fonksiyonlari ,sayma fonksiyonlari)

-- Sayma : Count()
select count(*) from Orders -- Tablodaki kayit sayisi. Her iki database vendor icin ayni sekilde kullanilir.

-- 1997 yilinda Almanya kac adet siparis vermistir ? Postgresql
select count(*) from orders where date_part('year',order_date)=1997 and ship_country='Germany'
-- Sql server
--select count(*) from orders where year(orderdate)=1997 and shipcountry='Germany'
select count(first_name) from employees
select count(region) from employees -- count null olan alanlari saymaz
--region alani null olan kaç adet kayit vardir .Employee tablosunda
select count(*) from employees where region is null
-- tekil kayit
select  count(distinct country) from employees -- tablodaki tekil kayitlari bulmaya yarar

-- Sum Toplama 
-- product_id'si 1 olan yani cay olan urun kac adet satilmistir
select * from order_details where product_id=1
select sum(quantity) from order_details where product_id=1 -- 828 adet cay satilmis
--caydan elde edilen ciro nedir 
select  sum(quantity * unit_price)  ToplamCiro,
        sum(quantity * unit_price*(1-discount))  IndirimliCiro 
from order_details 
where product_id=1

-- Sql server icin 
select  sum(quantity * unitprice)  ToplamCiro,
        sum(quantity * unitprice*(1-discount))  IndirimliCiro 
from [order details] 
where productid=1

-- Tarih alanlari ,metin alanlari icin sum 
select sum(birth_date) from employees -- tarih alanlari icn direk olarak calismaz

select sum(date_part('year',birth_date))/count(*) from employees
select avg(date_part('year',birth_date)) from employees
-- Çay 'larin ortalama siparis adetleri 
select avg(quantity) from order_details where product_id=1
-- sql server
select avg(quantity) from [Order Details] where productid=1

-- *********** Yuvarlama ******************
--Sql server Round . Normal Yuvarlama

select ROUND(234.111,-1); -- 230
select ROUND(239.111,-1); -- 240
select ROUND(235.111,-1); -- 230


select ROUND(234.111,0); -- 234
select ROUND(239.111,0); -- 239
select ROUND(235.111,0); -- 235



select ROUND(234.111,1); -- 234
select ROUND(239.111,1); -- 239
select ROUND(235.111,1); -- 235

-- Yukari Yuvarlama 
select CEILING(234.111)
select CEILING(9.5)
select CEILING(10.5)
select CEILING(11.5)
select CEILING(12.5)

-- Asagi Yuvarlama 
select Floor(234.999)
select Floor(9.5)
select Floor(10.5)
select Floor(11.5)
select Floor(12.5)

--**************** Max , Min ***********
select  max(UnitPrice) from Products
select ProductName, max(UnitPrice) from Products -- Bu kod hata verecektir. 
                                                 -- Group by kullanlmadiginda max ve min yanliz kullanilir
-- max olmasaydi en pahali urun nasil bulunurdu 
select top 1 * from Products order by UnitPrice desc -- Azalan sekilde siralar 

select min(unitprice) from Products 
select min(birthdate)  from Employees -- Tarih alanlarinda da calisir
select max(birthdate)  from Employees -- Tarih alanlarinda da calisir
select min(FirstName)  from Employees -- string alanlarda calisir
select max(FirstName)  from Employees -- string alanlarda calisir
-- postgresql icin 
select min(birth_date)  from Employees -- Tarih alanlarinda da calisir
select max(birth_date)  from Employees -- Tarih alanlarinda da calisir
select min(First_Name)  from Employees -- string alanlarda calisir
select max(First_Name)  from Employees -- string alanlarda calisir
select  * from Products order by Unit_Price desc limit 1 -- Azalan sekilde siralar 

--********* Group by Kullanimi *************
-- kac farkli ulke var 
select count(distinct country) from employees

-- bu ülkelerden kac adet var 
select country ,count(country) 
from employees
group by country

-- ulkelere gore musteri sayisi dagilimi nedir?
select country,count(*) 
from customers
group by country
order by count(*)  desc

select country,count(*)
from customers
group by country
order by 2 desc


select country,count(*) adet
from customers
group by country
order by adet desc

-- Hem ulke hemde sehire gore gruplama
select country,city ,count(*) adet
from customers
group by country,city 
order by adet desc

-- 1997 yilinda hang ulke kac adet siparis vermistir.
select ship_country ,count(*) adet
from orders
where date_part('year',order_date) = 1997
GROUP by ship_country 
order by adet desc

-- 1997 yilindaki siparislerin aylara gore dagilimi nedir ?
select date_part('month',order_date) Ay,count(*) adet
from orders
where date_part('year',order_date) = 1997
GROUP by date_part('month',order_date)
order by  Ay

-- 1997 yilinda en az siparis alan elemanlar kimlerdir ?
SELECT employee_id, COUNT(*) AS adet
FROM orders
WHERE DATE_PART('year', order_date) = 1997
GROUP BY employee_id
ORDER BY adet ASC
LIMIT 1;

-- 1997 yilinda en çok siparis alan elemanlar kimlerdir ?
SELECT employee_id, COUNT(*) AS adet
FROM orders
WHERE DATE_PART('year', order_date) = 1997
GROUP BY employee_id
ORDER BY adet DESC
LIMIT 1;

-- 1997 yilinda kargo firmalarinin tasidigi siparis sayisi nedir ?
SELECT ship_via, COUNT(*) AS adet
FROM orders
WHERE DATE_PART('year', order_date) = 1997
GROUP BY ship_via
ORDER BY adet DESC;

-- kargo firmalarinin yillara gore tasidiklari siparis dagilimi nedir
SELECT DATE_PART('year', order_date) AS yil, ship_via, COUNT(*) AS adet
FROM orders
GROUP BY yil, ship_via
ORDER BY yil ASC, adet DESC;

-- Hangi kategoride kaç adet urun var  ? 
SELECT category_id, COUNT(*) as adet
FROM products
GROUP BY category_id
ORDER BY adet ;

-- Toplamda en fazla siparis alan ilk 3 calisana odul verilecektir. Bunlar kimlerdir.
SELECT employee_id, COUNT(*) AS adet
FROM orders
GROUP BY employee_id
ORDER BY adet DESC
LIMIT 3;

-- En az siparis veren ilk 3 musteri kimlerdir. Daha fazla uzerine dusun .Indirim yapin

