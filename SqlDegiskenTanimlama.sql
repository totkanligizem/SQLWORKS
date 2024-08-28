
declare @sayi as int = 1234567890123; -- sayisal veri tipleri
select @sayi 
declare @para as decimal(10,2) = 45.67;
select @para 

declare @id as bigint = 1234567890123;
select @id
declare @tarih as Datetime = Getdate(); -- Tarih veri tipi 

--Degiskenleri ekrana yazdirmak icin 
print @tarih
select @tarih

declare @guid as uniqueidentifier; --09B7F777-388E-4828-8140-7C292D214AA5
--Degiskenlere deger atanmasi 
--1 yol set komutu
set @guid = NEWID(); 
select @guid 
-- 2. yol 
select @guid = NEWID();
select @guid 