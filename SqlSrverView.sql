create view MusteriView
as 
 select c.CustomerID,
        month(o.OrderDate) Ay, 
        sum(od.Quantity*od.UnitPrice) ciro 
        from Orders o
        inner join customers c on c.CustomerID=o.CustomerID
        inner join [Order Details] od  on od.OrderID=o.OrderID
        group by c.CustomerID,month(o.OrderDate)

select * 
from   MusteriView   --where CustomerID = 'Quick'   
where Ay=12     

select * from Invoices