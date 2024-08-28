-- Bugunun tarihi
--Sql server da GetDate()
select CURRENT_DATE;
--postgresql icin 
select CURRENT_TIME;
select CURRENT_TIMESTAMP;

-- DatePart Kullanmimi 
select date_part('year',CURRENT_TIMESTAMP) -- yili verir
select date_part('month',CURRENT_TIMESTAMP) -- ay verir
select date_part('day',CURRENT_TIMESTAMP) -- gun verir
-- 1997 yilinin 3. ayindaki siparisler 
select * from orders where date_part('year',order_date)=1997 
            and  date_part('month',order_date)=3;
-- sql server 
select * from orders where datepart(year,orderdate)=1997 
            and  datepart(month,orderdate)=3;
select * from orders where year(OrderDate)=1997 and month(OrderDate)=3  

--asagidaki kod  postgresql de calismaz
-- select * from orders where YEAR(order_date)=1997 
--             and  MONTH(order_date)=3;
select * from employees
-- Calisanlarin yaşlarini bulalim . DateDiff sql server da kullanilir.
select FirstName,LastName,DateDiff(year,BirthDate,Getdate()) 'Yas'
from Employees


-- postgresql ile calisanlarin yaşlarini bulma
select First_Name,Last_Name, 
(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date)) yas  
from employees 

-- yilin kacıncı gunu oldugunu veren sql server kullanimi 
select DATEPART(DAYOFYEAR,GetDate());
-- postgresql kullanimi 
select date_part('doy',CURRENT_DATE) -- yilin kacinci gunu
select date_part('dow',CURRENT_DATE) -- haftanin kacinci gunu
--decade
select date_part('decade',CURRENT_DATE)
select date_part('decade',TIMESTAMP '1890-01-01')

 