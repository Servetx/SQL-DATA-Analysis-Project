/* =============================================================
   AGGRIGATION (TOPLAMLAR), GRUPLAMA VE TABLO BİRLEŞTİRME (JOIN)
   ============================================================= */

/* 1. Sistemdeki toplam sipariş satırı sayısını bulur */
SELECT COUNT(*)
FROM df_OrderItems;

-- NEDEN BÖYLE YAZDIK?: 
-- 'COUNT(*)' tablodaki bütün satırları sayar. Toplam kaç adet ürün kalemi satıldığını hızlıca görmek için kullandık.


/* 2. Satılan tüm ürünlerin toplam cirosunu hesaplar */
SELECT SUM(Price) AS Toplam_Fiyat
FROM df_OrderItems;

-- NEDEN BÖYLE YAZDIK?: 
-- 'SUM' sütundaki tüm sayıları toplar. Şirketin kazandığı toplam brüt parayı bulmak için yazdık.


/* 3. En ucuz ve en pahalı ürün fiyatlarını bulur */
SELECT MIN(Price) AS En_Az_Fiyat
FROM df_OrderItems;

SELECT MAX(Price) AS En_Yüksek_Fiyat
FROM df_OrderItems;

-- NEDEN BÖYLE YAZDIK?: 
-- 'MIN' tablodaki en düşük fiyatı, 'MAX' ise en yüksek fiyatı cımbızla çeker gibi getirir. (Not: MIN sorgusuna 'AS' eklendi).


/* 4. Satılan ürünlerin ortalama fiyatını hesaplar */
SELECT AVG(Price) AS Ortalama_Fiyat
FROM df_OrderItems;

-- NEDEN BÖYLE YAZDIK?: 
-- 'AVG' (Average) sistemdeki fiyat ortalamasını verir. Müşterilerin genelde ne kadarlık ürünlere yöneldiğini anlamamızı sağlar.


/* 5. Müşteri bazında toplam harcama tutarını bulur ve en çok para harcayandan aşağıya sıralar */
SELECT C.Customer_id, SUM(Oi.Price) AS Toplam_Fiyat 
FROM df_Customers AS C 
JOIN df_Orders AS O ON C.Customer_id = O.Customer_id 
JOIN df_OrderItems AS Oi ON O.order_id = Oi.order_id 
GROUP BY C.Customer_id 
ORDER BY Toplam_Fiyat DESC;

-- NEDEN BÖYLE YAZDIK?: 
-- Üç farklı tabloyu 'JOIN' ile birbirine bağladık çünkü müşteri bilgisi ayrı, sipariş durumu ayrı, fiyat ayrı tablodadır.
-- 'GROUP BY' kullanarak her bir müşteriyi tek satıra topladık ve 'SUM' ile o müşterinin yaptığı tüm harcamaları toplattık.
