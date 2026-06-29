/* =============================================================
   E-TICARET IS ODAKLI SQL ANALIZI
   Dosya: 04_Business_Window_Function_Analysis.sql
   Konu: Window Functions ile is analizi
   Veritabani: SQL Server

   Amac:
   ROW_NUMBER kullanarak musteri, kategori, satici, odeme turu,
   sehir ve eyalet bazinda siralama analizleri yapmak.

   Kullanilan SQL konulari:
   - ROW_NUMBER ile sira numarasi verme
   - OVER ile siralama kuralini belirleme
   - ORDER BY ile rank hesaplama
   - GROUP BY ile analiz seviyesini belirleme
   - SUM ile toplam gelir ve odeme tutari hesaplama

   Not:
   ROW_NUMBER() OVER (ORDER BY toplam_deger DESC)
   en yuksek degere 1 numarali sirayi verir.
   ============================================================= */


/* Is Sorusu 1:
   Musterileri toplam urun harcamasina gore sirala.
   En cok harcayan musteri 1. sirada olsun.
*/
SELECT
    c.customer_id,
    SUM(oi.price) AS total_customer_expenditure,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS customer_expenditure_rank
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id
ORDER BY
    customer_expenditure_rank ASC;


/* Is Sorusu 2:
   Kategori bazinda toplam urun satis gelirini hesapla.
   En yuksek gelir getiren kategori 1. sirada olsun.
*/
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_category_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS category_revenue_rank
FROM df_Products p
JOIN df_OrderItems oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_category_name
ORDER BY
    category_revenue_rank ASC;


/* Is Sorusu 3:
   Satici bazinda toplam urun satis gelirini hesapla.
   En yuksek gelir getiren satici 1. sirada olsun.
*/
SELECT
    oi.seller_id,
    SUM(oi.price) AS total_product_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS seller_revenue_rank
FROM df_OrderItems oi
GROUP BY
    oi.seller_id
ORDER BY
    seller_revenue_rank ASC;


/* Is Sorusu 4:
   Odeme turu bazinda toplam odeme tutarini hesapla.
   En yuksek odeme tutarina sahip odeme turu 1. sirada olsun.
*/
SELECT
    p.payment_type,
    SUM(p.payment_value) AS total_payment_value,
    ROW_NUMBER() OVER (ORDER BY SUM(p.payment_value) DESC) AS total_payment_value_rank
FROM df_Payments p
GROUP BY
    p.payment_type
ORDER BY
    total_payment_value_rank ASC;


/* Is Sorusu 5:
   Sehir bazinda toplam urun satis gelirini hesapla.
   En yuksek gelir getiren sehir 1. sirada olsun.
*/
SELECT
    c.customer_city,
    SUM(oi.price) AS total_city_product_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS city_revenue_rank
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_city
ORDER BY
    city_revenue_rank ASC;


/* Is Sorusu 6:
   Eyalet bazinda toplam urun satis gelirini hesapla.
   En yuksek gelir getiren eyalet 1. sirada olsun.
*/
SELECT
    c.customer_state,
    SUM(oi.price) AS total_state_product_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS state_revenue_rank
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    state_revenue_rank ASC;


/* Is Sorusu 7:
   Musteri bazinda toplam odeme tutarini hesapla.
   En yuksek odeme yapan musteri 1. sirada olsun.
*/
SELECT
    c.customer_id,
    SUM(p.payment_value) AS total_customer_payment_value,
    ROW_NUMBER() OVER (ORDER BY SUM(p.payment_value) DESC) AS customer_payment_value_rank
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_Payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id
ORDER BY
    customer_payment_value_rank ASC;
