CREATE OR REPLACE FUNCTION stok_Kontrol()
RETURNS TRIGGER LANGUAGE PLPGSQL
AS
$$
DECLARE
    stokmiktari int;
    fark int;
BEGIN
    -- Yeni eklenen kayıtla ilgili bilgi vermek için
    RAISE NOTICE 'Yeni eklenen kayıt: %', NEW;

    -- Ürün stoğunu alıyoruz
    SELECT p.units_in_stock INTO stokmiktari 
    FROM products p 
    WHERE p.product_id = NEW.product_id;

    -- Stok farkını hesaplıyoruz
    fark := stokmiktari - NEW.quantity;

    -- Eğer stok yetersizse, bir hata fırlatılır
    IF fark < 1 THEN
        RAISE EXCEPTION 'Yetersiz stok! Ürün ID: %, Stok: %, Talep Edilen: %', NEW.product_id, stokmiktari, NEW.quantity;
    END IF;

    -- İşlemi devam ettirmek için NEW'i döndür
    RETURN NEW;
END;
$$;

CREATE TRIGGER order_details_insert_before
BEFORE INSERT 
ON order_details
FOR EACH ROW 
EXECUTE FUNCTION stok_Kontrol();

INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 1, 10, 100, 0);

SELECT * FROM order_details LIMIT 1;

