/* =============================================================
   WINDOW FUNCTION EXPRESSION VE KAMPANYA ANALİZİ PRATİKLERİ
   ============================================================= */

SELECT
    C.Customer_id,
    C.Customer_city,
    SUM(Oi.Price) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (PARTITION BY C.Customer_City ORDER BY SUM(Oi.Price) DESC) Sehir_ici_sıra
FROM df_Customers C
JOIN df_Orders O ON C.customer_id = O.customer_id
JOIN df_OrderItems Oi ON O.order_id = Oi.order_id
GROUP BY C.customer_id, C.customer_city
HAVING SUM(Oi.Price) >= 0.8500
ORDER BY Toplam_Fiyat DESC, Sehir_ici_sıra ASC;

-- NEDEN BÖYLE YAZDIK?: 
-- Müşterileri harcamalarına göre segmentlere ayırıp,
--her şehrin en çok harcayanşampiyonlarını 'ROW_NUMBER' ile yukarıdan aşağıya listelemek için kullandık.


SELECT
    C.Customer_id,
    C.Customer_city,
    SUM(Oi.Price) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (PARTITION BY C.Customer_City ORDER BY SUM(Oi.Price) DESC) Sehir_ici_sıra
FROM df_Customers C
LEFT JOIN df_Orders O ON C.customer_id = O.customer_id
LEFT JOIN df_OrderItems Oi ON O.order_id = Oi.order_id
WHERE C.customer_city IN ('osasco', 'sao paulo', 'sorocaba')
GROUP BY C.customer_id, C.customer_city
HAVING SUM(Oi.Price) >= 0.8500 OR SUM(Oi.Price) IS NULL
ORDER BY Toplam_Fiyat DESC, Sehir_ici_sıra ASC;

-- NEDEN BÖYLE YAZDIK?: 
-- Hedeflenen 3 şehirdeki sadık müşterileri listelerken, 'LEFT JOIN' ve 'IS NULL' kullanarak sisteme kayıtlı olup henüz hiç alışveriş yapmamış,
--potansiyel kampanya müşterilerini de kaçırmamak için kullandık.


SELECT
    C.Customer_id,
    C.Customer_city,
    ROUND(SUM(Oi.Price), 2) AS Toplam_Fiyat,
    CASE
        WHEN SUM(Oi.Price) >= 6735 THEN 'Elit'
        WHEN SUM(Oi.Price) >= 4799 THEN 'Vip'
        ELSE 'Standart'
    END AS Musteri_Segmenti,
    ROW_NUMBER() OVER (PARTITION BY C.Customer_City ORDER BY SUM(Oi.Price) DESC) Sehir_ici_sıra
FROM df_Customers C
LEFT JOIN df_Orders O ON C.customer_id = O.customer_id
LEFT JOIN df_OrderItems Oi ON O.order_id = Oi.order_id
WHERE C.customer_city IN ('osasco', 'sao paulo', 'sorocaba')
GROUP BY C.customer_id, C.customer_city
HAVING SUM(Oi.Price) >= 0.8500 OR SUM(Oi.Price) IS NULL
ORDER BY Toplam_Fiyat DESC, Sehir_ici_sıra ASC;

-- NEDEN BÖYLE YAZDIK?: 
-- Hedeflenen 3 şehirdeki sadık müşterileri listelerken, 'LEFT JOIN' ve 'IS NULL' kullanarak 
-- sisteme kayıtlı olup henüz hiç alışveriş yapmamış potansiyel kampanya müşterilerini de 
-- kaçırmamak için kullandık. 'ROUND' fonksiyonu ile de virgülden sonraki karmaşık kuruş 
-- hanelerini temizleyip raporu okunabilir hale getirdik.


