create view MusteriSiparisleri 
as 
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

select * from MusteriSiparisleri where ulke= 'Germany'