```sql
/* =============================================================
   WINDOW FUNCTIONS AND CUSTOMER SEGMENTATION PRACTICES
   Dataset: Olist Brazil E-Commerce
   ============================================================= */


-- Müşterileri toplam harcamalarına göre segmentlere ayırır.
-- ROW_NUMBER ile her şehir içinde en yüksek harcama yapan müşteriler sıralandı.
SELECT
    C.Customer_id,
    C.Customer_city,
    SUM(Oi.Price) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (
        PARTITION BY C.Customer_City 
        ORDER BY SUM(Oi.Price) DESC
    ) AS Sehir_ici_sira
FROM df_Customers AS C
JOIN df_Orders AS O 
    ON C.customer_id = O.customer_id
JOIN df_OrderItems AS Oi 
    ON O.order_id = Oi.order_id
GROUP BY 
    C.customer_id, 
    C.customer_city
HAVING 
    SUM(Oi.Price) >= 0.8500
ORDER BY 
    Toplam_Fiyat DESC, 
    Sehir_ici_sira ASC;


-- Belirli şehirlerdeki müşterileri toplam harcamalarına göre segmentlere ayırır.
-- LEFT JOIN kullanılarak siparişi olmayan müşteriler de analizde tutuldu.
SELECT
    C.Customer_id,
    C.Customer_city,
    SUM(Oi.Price) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (
        PARTITION BY C.Customer_City 
        ORDER BY SUM(Oi.Price) DESC
    ) AS Sehir_ici_sira
FROM df_Customers AS C
LEFT JOIN df_Orders AS O 
    ON C.customer_id = O.customer_id
LEFT JOIN df_OrderItems AS Oi 
    ON O.order_id = Oi.order_id
WHERE 
    C.customer_city IN ('osasco', 'sao paulo', 'sorocaba')
GROUP BY 
    C.customer_id, 
    C.customer_city
HAVING 
    SUM(Oi.Price) >= 0.8500 
    OR SUM(Oi.Price) IS NULL
ORDER BY 
    Toplam_Fiyat DESC, 
    Sehir_ici_sira ASC;


-- Belirli şehirlerdeki müşteri segmentlerini daha okunabilir fiyat formatıyla listeler.
-- ROUND ile toplam harcama değeri iki ondalık basamağa yuvarlandı.
SELECT
    C.Customer_id,
    C.Customer_city,
    ROUND(SUM(Oi.Price), 2) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (
        PARTITION BY C.Customer_City 
        ORDER BY SUM(Oi.Price) DESC
    ) AS Sehir_ici_sira
FROM df_Customers AS C
LEFT JOIN df_Orders AS O 
    ON C.customer_id = O.customer_id
LEFT JOIN df_OrderItems AS Oi 
    ON O.order_id = Oi.order_id
WHERE 
    C.customer_city IN ('osasco', 'sao paulo', 'sorocaba')
GROUP BY 
    C.customer_id, 
    C.customer_city
HAVING 
    SUM(Oi.Price) >= 0.8500 
    OR SUM(Oi.Price) IS NULL
ORDER BY 
    Toplam_Fiyat DESC, 
    Sehir_ici_sira ASC;
```
