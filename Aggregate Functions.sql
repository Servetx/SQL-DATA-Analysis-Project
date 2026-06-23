-- df_OrderItems tablosundaki toplam kayıt sayısı
-- Veri setinde kaç adet sipariş kalemi olduğunu kontrol eder
SELECT COUNT(*)
FROM df_OrderItems;


-- Tüm sipariş kalemlerinin toplam fiyatı
-- Toplam ciroyu görmek için kullanılır
SELECT SUM(Price) AS Toplam_Fiyat
FROM df_OrderItems;


-- En düşük fiyatlı sipariş kalemi
-- Fiyat aralığını analiz etmek için kullanılır
SELECT MIN(Price) AS En_Az_Fiyat
FROM df_OrderItems;


-- En yüksek fiyatlı sipariş kalemi
-- Maksimum değer tespiti için kullanılır (outlier kontrolü)
SELECT MAX(Price) AS En_Yüksek_Fiyat
FROM df_OrderItems;


-- Ortalama fiyat hesaplama
-- Ürünlerin genel fiyat seviyesini görmek için kullanılır
SELECT AVG(Price) AS Ortalama_Fiyat
FROM df_OrderItems;


-- Müşteri bazlı toplam harcama analizi
-- Amaç: Her müşterinin toplam harcamasını hesaplamak

-- df_Customers -> df_Orders -> df_OrderItems
-- Bu tablo zinciri müşteri sipariş ilişkisini kurar

-- JOIN: tabloları ilişkilendirir
-- GROUP BY: müşteri bazında gruplar
-- SUM: toplam harcamayı hesaplar
SELECT 
    C.Customer_id,
    SUM(Oi.Price) AS Toplam_Fiyat 
FROM df_Customers AS C 
JOIN df_Orders AS O 
    ON C.Customer_id = O.Customer_id 
JOIN df_OrderItems AS Oi 
    ON O.order_id = Oi.order_id 
GROUP BY C.Customer_id 
ORDER BY Toplam_Fiyat DESC;
