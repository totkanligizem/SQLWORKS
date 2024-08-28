SELECT first_name

SELECT first_name,last_name,
CASE(country)

WHEN 'USA' THEN 'Amerika'
WHEN 'UK' THEN 'Ingiltere'
end ulke
FROM employees

SELECT 
    product_name,
    unit_price,
    CASE
        WHEN unit_price < 50 THEN 'ucuz ürün'
        WHEN unit_price >= 50 AND unit_price < 120 THEN 'ekonomik ürün'
        WHEN unit_price >= 120 AND unit_price < 1200 THEN 'pahalı ürün'
        ELSE 'lux urun'
    END AS ürün_kategorisi
FROM 
    products;
