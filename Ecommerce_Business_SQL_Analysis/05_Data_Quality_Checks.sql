/* =============================================================
   E-TICARET IS ODAKLI SQL ANALIZI
   Dosya: 05_Data_Quality_Checks.sql
   Konu: Data Quality Checks
   Veritabani: SQL Server

   Amac:
   Analiz sonuclarinin guvenilir olmasi icin tekrar eden ID,
   hatali tutar, bos kategori ve eslesmeyen kayit kontrolleri yapmak.

   Kullanilan SQL konulari:
   - COUNT ve COUNT(DISTINCT)
   - GROUP BY ve HAVING
   - WHERE ile problemli kayit filtreleme
   - IS NULL ve bos metin kontrolu
   - CASE WHEN ile veri durum siniflandirma
   - LEFT JOIN ile eslesmeyen kayit bulma
   ============================================================= */


/* Is Sorusu 1:
   Musteri tablosunda toplam musteri satiri ile benzersiz musteri sayisini karsilastir.
   Tekrarli musteri kaydi var mi kontrol et.
*/
SELECT
    COUNT(customer_id) AS total_customer_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_count
FROM df_Customers;


/* Is Sorusu 2:
   Musteri tablosunda tekrar eden musteri ID'lerini listele.
*/
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM df_Customers
GROUP BY
    customer_id
HAVING
    COUNT(*) > 1;


/* Is Sorusu 3:
   Siparis tablosunda toplam siparis satiri ile benzersiz siparis sayisini karsilastir.
   Tekrarli siparis kaydi var mi kontrol et.
*/
SELECT
    COUNT(order_id) AS total_order_rows,
    COUNT(DISTINCT order_id) AS unique_order_count
FROM df_Orders;


/* Is Sorusu 4:
   Siparis tablosunda tekrar eden siparis ID'lerini listele.
*/
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM df_Orders
GROUP BY
    order_id
HAVING
    COUNT(*) > 1;


/* Is Sorusu 5:
   Siparis kalemleri tablosunda fiyati 0 veya negatif olan kayit var mi kontrol et.
*/
SELECT
    order_id,
    product_id,
    seller_id,
    price
FROM df_OrderItems
WHERE
    price <= 0;


/* Is Sorusu 6:
   Siparis kalemleri tablosunda kargo ucreti negatif olan kayit var mi kontrol et.
   Not: Kargo ucretinin 0 olmasi ucretsiz kargo olabilir; negatif olmasi suphelidir.
*/
SELECT
    order_id,
    product_id,
    seller_id,
    shipping_charges
FROM df_OrderItems
WHERE
    shipping_charges < 0;


/* Is Sorusu 7:
   Odeme tablosunda odeme tutari 0 veya negatif olan kayit var mi kontrol et.
*/
SELECT
    order_id,
    payment_type,
    payment_value,
    payment_installments,
    payment_sequential
FROM df_Payments
WHERE
    payment_value <= 0;


/* Is Sorusu 8:
   Urun tablosunda kategori bilgisi NULL veya bos metin olan urunleri listele.
*/
SELECT
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM df_Products
WHERE
    product_category_name IS NULL
    OR product_category_name = '';


/* Is Sorusu 9:
   Urun kategori alaninin doluluk durumunu ozetle.
   NULL, bos metin ve dolu kategori sayilarini ayri ayri goster.
*/
SELECT
    CASE
        WHEN product_category_name IS NULL THEN 'NULL'
        WHEN product_category_name = '' THEN 'EMPTY_STRING'
        ELSE 'FILLED'
    END AS category_status,
    COUNT(*) AS product_count
FROM df_Products
GROUP BY
    CASE
        WHEN product_category_name IS NULL THEN 'NULL'
        WHEN product_category_name = '' THEN 'EMPTY_STRING'
        ELSE 'FILLED'
    END;


/* Is Sorusu 10:
   Siparis tablosundaki her musteri ID, musteri tablosunda var mi kontrol et.
   Musteri tablosuyla eslesmeyen siparisleri listele.
*/
SELECT
    o.order_id,
    o.customer_id
FROM df_Orders o
LEFT JOIN df_Customers c
    ON o.customer_id = c.customer_id
WHERE
    c.customer_id IS NULL;


/* Is Sorusu 11:
   Siparis kalemleri tablosundaki her urun ID, urun tablosunda var mi kontrol et.
   Urun tablosuyla eslesmeyen siparis kalemlerini listele.
*/
SELECT
    oi.order_id,
    oi.product_id,
    oi.seller_id
FROM df_OrderItems oi
LEFT JOIN df_Products p
    ON oi.product_id = p.product_id
WHERE
    p.product_id IS NULL;
