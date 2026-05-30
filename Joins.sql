-- =================================================================================
-- SQL JOIN STRATEJİLERİ VE VERİ BİRLEŞTİRME ANALİZLERİ
-- =================================================================================

-- ---------------------------------------------------------------------------------
-- 1. ANALİZ: INNER JOIN
-- ---------------------------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_city,
    oi.price,
    o.order_status,
    p.payment_value,
    ps.product_category_name
FROM df_customers c
JOIN df_orders o 
    ON c.customer_id = o.customer_id
JOIN df_order_items oi 
    ON o.order_id = oi.order_id
JOIN df_payments p
    ON oi.order_id = p.order_id
JOIN df_products ps 
    ON oi.product_id = ps.product_id;

-- [NEDEN YAPTIK?]: 
-- Bu JOIN'i yaptık çünkü sadece tüm tablolarda birbiriyle tamamen eşleşen ortak verileri 
-- almak istiyoruz. Siparişi olan, ödemesi sistemde görünen ve ürünü tanımlı olan eksiksiz 
-- satışları listeler. Eşleşmeyen hiçbir satırı getirmez, temiz ve net ciro analizi sağlar.


-- ---------------------------------------------------------------------------------
-- 2. ANALİZ: LEFT JOIN
-- ---------------------------------------------------------------------------------
SELECT
    c.customername,
    c.city,
    p.productname,
    o.amount
FROM customers c
LEFT JOIN orders o 
    ON c.customerid = o.customerid
LEFT JOIN products p
    ON o.productid = p.productid;

-- [NEDEN YAPTIK?]: 
-- Bu JOIN'i yaptık çünkü soldaki ana tablonun (customers) ne olursa olsun tamamını almak istiyoruz. 
-- Sağdaki tablodan (orders) bir sipariş eşleşmesi gelmese bile o müşteriyi listede tutar, 
-- sipariş kısımlarını NULL (boş) bırakır. Amacımız; sisteme kayıtlı olan ama henüz hiç alışveriş 
-- yapmamış pasif müşterileri tespit etmektir.


-- ---------------------------------------------------------------------------------
-- 3. ANALİZ: FULL JOIN
-- ---------------------------------------------------------------------------------
SELECT
    c.customername,
    c.city,
    o.amount,
    p.category,
    p.productname
FROM customers c
FULL JOIN orders o
    ON c.customerid = o.customerid
FULL JOIN products p 
    ON o.productid = p.productid;

-- [NEDEN YAPTIK?]: 
-- Bu JOIN'i yaptık çünkü eşleşsin ya da eşleşmesin, sistemdeki hem soldaki (customers) hem de 
-- sağdaki (orders/products) tüm verilerin tamamını tek bir havuzda toplamak istiyoruz. 
-- Bunu yapma amacımız; müşteri bilgisi olmayan sahipsiz siparişleri veya siparişi olmayan 
-- müşterileri aynı anda görerek veri tabanındaki kayıp ve tutarsız kayıtları taramaktır.


-- ---------------------------------------------------------------------------------
-- 4. ANALİZ: RIGHT JOIN
-- ---------------------------------------------------------------------------------
SELECT
    c.customername,
    c.city,
    o.amount,
    p.category,
    p.productname
FROM customers c
RIGHT JOIN orders o
    ON c.customerid = o.customerid
RIGHT JOIN products p 
    ON o.productid = p.productid;

-- [NEDEN YAPTIK?]: 
-- Bu JOIN'i yaptık çünkü sağdaki tabloların (orders ve products) ne olursa olsun tamamını almak istiyoruz. 
-- Eğer o siparişi veren müşterinin kaydı soldaki tabloda (customers) silinmiş veya bozulmuş olsa bile, 
-- yapılan satışı ve harcanan miktarı (amount) kaybetmeden raporda görmek için bu yapıyı kurduk.
