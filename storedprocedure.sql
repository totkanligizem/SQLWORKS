/*
sql veri tipleri :
sql server de değişken anımlama =>
*/

CREATE OR REPLACE PROCEDURE KargoFirmalarıSiparisDagilimi
(kargoFirması varchar(50), yil int)
LANGUAGE plpgsql
as $$
BEGIN

if(kargoFirması is null and yil is NULL) THEN
    select date_part ('year',o.order_date) Yil, s.company_name,count(*) adet
    from orders o 
    inner join shippers s on s.shipper_id = o.ship_via
    group by date_part('year',o.order_date) ,s.company_name
    order by adet;
else  
    select date_part ('month',o.order_date) Yil, s.company_name,count(*) adet
    from orders o 
    inner join shippers s on s.shipper_id = o.ship_via
    where s.company_name = kargoFirması and date_part('month',o.order_date) =yil
    group by date_part('month',o.order_date) ,s.company_name
    order by adet;
end if;
end;$$


CALL KargoFirmalarıSiparisDagilimi



