SELECT Orders.Order_ID, customers.company_name, Orders.Order_Date
FROM Orders
INNER JOIN customers ON Orders.customer_ID=customers.customer_ID;

select * from orders o limit 10

select o.order_id SiparisNo,
        c.company_name Musteri,
        (e.first_name||' '||e.last_name) calisan,
        o.order_date SiparisTarihi ,
        s.company_name Kargo , 
        o.ship_city sehir , 
        o.ship_country Ulke
from orders o 
inner join customers c on c.customer_id =  o.customer_id
inner join employees e on e.employee_id =  o.employee_id 
inner join shippers s  on s.shipper_id  =  o.ship_via 
where o.ship_country = 'UK'
order by o.order_date desc

-- kargo firmalarinin taşıdıgı urunlerin yillara gore dagilimi
select date_part('year',o.order_date) Yil ,s.company_name ,count(*) Adet
from orders o 
inner join shippers s  on s.shipper_id  =  o.ship_via 
group by date_part('year',o.order_date)  ,s.company_name 
order by Adet 


-- 
select * from orders o limit 3;
select * from order_details limit 5

-- her siprisin toplam tutari nedir ?
select o.order_id ,c.company_name , Round(sum(od.unit_price * od.quantity)) ciro 
from orders o
inner join order_details od on od.order_id = o.order_id 
inner join customers c on c.customer_id = o.customer_id
group by  o.order_id ,c.company_name
order by o.order_id 

-- 1997 yilndaki calisanlarin yaptigi cirolar nedir ? 
select  (e.first_name||' '||e.last_name) calisan,
Round(sum(od.quantity*od.unit_price)) Ciro
from employees e 
left join orders o on e.employee_id=o.employee_id
left   join order_details od on od.order_id= o.order_id 
--where o.ship_country='USA' --date_part('year',o.order_date)=1997
group by (e.first_name||' '||e.last_name)
order by ciro 


select * from employees where employee_id=10
select * from orders where employee_id =10

select (e.first_name||' '||e.last_name) ,count(o.order_id)
from orders o 
RIGHT join employees e on e.employee_id=o.employee_id 
group by (e.first_name||' '||e.last_name) 


select p.Product_name ,sum(od.quantity) siparisSayisi
from products p
left join order_details od on od.product_id= p.product_id 
group by p.product_name 
having sum(od.quantity) is null 


-- Buna bakilacak where sarti arastirilacak
select (e.first_name ||' '||e.last_name),
Round(sum(od.unit_price*od.quantity)) ciro 
from employees e
Left join orders o on e.employee_id=o.employee_id
LEFT join order_details od on o.order_id=od.order_id
--where date_part('year',o.order_date)=1997
group by (e.first_name||' '||e.last_name)
order by ciro desc
 

-- 1- 1997 yilinin aylara gore ciro dagilimi nedir.
select MONTH(o.orderdate) Ay, sum(od.Quantity*od.UnitPrice) ciro 
from Orders o
inner join [Order Details] od  on od.OrderID=o.OrderID
where year(o.OrderDate)=1997 
group by MONTH(o.orderdate) 
order by MONTH(o.orderdate) 
-- 2 - Almanyanin Yillara gore toplam cirosu nedir ?
select year(o.OrderDate), sum(od.Quantity*od.UnitPrice) ciro 
from Orders o
inner join customers c on c.CustomerID=o.CustomerID
inner join [Order Details] od  on od.OrderID=o.OrderID
where  c.Country = 'Germany'
group by year(o.OrderDate)
order by year(o.OrderDate) 
-- 3- Kategorilerin cirolari nedir ?

select c.CategoryName,sum(od.Quantity*od.UnitPrice) ciro 
from Categories c 
inner join Products p on c.CategoryID = p.CategoryID
inner join [Order Details] od on od.ProductID=p.ProductID
group by c.CategoryName


-- 4- Geç teslim edilen siparislerin listesi ve buradaki ciro  nedir ?
-- Birde bu siparisteki urunleri tedarik ettigim firmalar hangileridir.
--SqlServer
select s.companyname,
        p.productname,            
        o.requireddate,
        o.shippeddate,
		DateDiff(day,o.requireddate,o.shippeddate) GunFarki,
        sum(od.quantity*od.unitprice) ciro
 from orders o
 inner join [Order details] od on od.orderid=o.orderid
 inner join products p on od.productid=p.productid
 inner join suppliers s on s.supplierid=p.supplierid
 where o.requireddate < o.shippeddate
 group by s.companyname,
        p.productname,
        o.requireddate,        
        o.shippeddate,
		datediff(day,o.requireddate,o.shippeddate)
 order by GunFarki desc,ciro desc

--PostgreSql
-- select s.company_name,
--         p.product_name,
--         o.order_id,        
--         o.required_date,
--         o.shipped_date,
--         sum(od.quantity*od.unit_price) ciro
--  from orders o
--  inner join Order_details od on od.order_id=o.order_id
--  inner join products p on od.product_id=p.product_id
--  inner join suppliers s on s.supplier_id=p.supplier_id
--  where o.required_date < o.shipped_date
--  group by s.company_name,
--         p.product_name,
--         o.required_date,
--         o.order_id, 
--         o.shipped_date,
--  order by ciro


SELECT o.order_id, 
        c.company_name AS musteri, 
        o.order_date AS siparis_tarihi, 
        o.required_date AS gerekli_tarih, 
        o.shipped_date AS teslim_tarihi, 
        (o.shipped_date - o.required_date) AS gecikme_gunu, 
        SUM(od.unit_price *od.quantity) AS ciro 
FROM orders o 
INNER JOIN order_details od ON od.order_id = o.order_id 
INNER JOIN customers c ON c.customer_id = o.customer_id 
WHERE o.shipped_date > o.required_date 
GROUP BY o.order_id, c.company_name, o.order_date, o.required_date, o.shipped_date 
ORDER BY o.shipped_date DESC;

-- 5 Ulkelere gore ciro dagilimlari 
SELECT
    c.country AS ulke,
    Round(SUM(od.unit_price * od.quantity)) AS toplam_ciro
FROM     orders o
INNER JOIN     order_details od ON o.order_id = od.order_id
INNER JOIN     customers c ON o.customer_id = c.customer_id
GROUP BY     c.country
ORDER BY     toplam_ciro DESC;