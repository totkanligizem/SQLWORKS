/*
like kullanimi 
*/
-- ilk harfi m olan calisanlar 
select * from employees where first_name ILIKE 'm%' 
-- first_name'i t ile biten calisanlar
select * from employees where first_name like '%t' 
-- first_name'i icerisinde an gecen  calisanlar
select * from employees where first_name like '%an%' 

-- first_name icerisinde ilk harf A olcak ikinci harf onemli degil ucuncu harf d olan calisanlar
select * from employees where first_name like 'A_d%' 

-- first_name icerisinde ilk harf A yada M olan calisanlar
--1. yol
select * from employees where first_name ILIKE 'A%' or first_name ILIKE 'M%' 
--2. yol sql Server'a ozgu bir yol 
select * from employees where first_name ILIKE '[AM]%'

-- Adinin icerisinde a yada l gecen kayitlar
select * from employees where first_name ILIKE '%A%' or first_name ILIKE '%L%' 
-- sql server'da 
select * from employees where first_name SIMILAR TO '%[al]%'
--firstname alaninda isimlerin j-r arasinda olan kayitlarin getirilmesi
-- Bu kod sadece sql server'da calisir
select * from employees where first_name like '[j-r]%' order by First_Name

select * from employees where first_name ~'^[J-R]' ORDER BY first_name

SELECT * FROM employees 
WHERE first_name SIMILAR TO '[J-Rj-r]%' 
ORDER BY first_name;