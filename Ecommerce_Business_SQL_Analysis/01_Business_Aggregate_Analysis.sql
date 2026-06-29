/* =============================================================
   E-TICARET IS ODAKLI SQL ANALIZI
   Konu: Aggregate Functions, GROUP BY, CASE WHEN
   Veritabani: SQL Server

   Amac:
   Temel SQL konularini is sorularina uygulamak.

   Kullanilan SQL konulari:
   - COUNT ile adet hesaplama
   - SUM ile gelir ve tutar hesaplama
   - AVG ile ortalama hesaplama
   - MIN ve MAX ile veri araligini kontrol etme
   - GROUP BY ile kirilim bazli analiz
   - CASE WHEN ile is segmentleri olusturma
   - ORDER BY ile sonuclari siralama
   ============================================================= */


/* Is Sorusu:
   Veri setinde kac farkli siparis vardir?
*/
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM df_Orders;


/* Is Sorusu:
   Veri setinde kac farkli musteri vardir?
*/
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM df_Customers;


/* Is Sorusu:
   Urun geliri, kargo geliri ve musterinin toplam odedigi tutar nedir?
*/
SELECT
    SUM(price) AS product_revenue,
    SUM(shipping_charges) AS shipping_revenue,
    SUM(price + shipping_charges) AS total_customer_paid_amount
FROM df_OrderItems;


/* Is Sorusu:
   Eyalete gore musteri sayisi nedir?
*/
SELECT
    customer_state,
    COUNT(customer_id) AS customer_number
FROM df_Customers
GROUP BY
    customer_state
ORDER BY
    customer_number DESC;


/* Is Sorusu:
   En cok musteri hangi sehirlerdedir?
*/
SELECT
    customer_city,
    COUNT(customer_id) AS customer_number
FROM df_Customers
GROUP BY
    customer_city
ORDER BY
    customer_number DESC;


/* Is Sorusu:
   Odeme tipine gore toplam odeme tutari nedir?
*/
SELECT
    payment_type,
    SUM(payment_value) AS payment_amount
FROM df_Payments
GROUP BY
    payment_type
ORDER BY
    payment_amount DESC;


/* Is Sorusu:
   Odeme tipine gore kac odeme islemi yapilmistir?
*/
SELECT
    payment_type,
    COUNT(*) AS payment_count
FROM df_Payments
GROUP BY
    payment_type
ORDER BY
    payment_count DESC;


/* Is Sorusu:
   Urun kategorisine gore kac urun vardir?
*/
SELECT
    product_category_name,
    COUNT(*) AS product_count
FROM df_Products
GROUP BY
    product_category_name
ORDER BY
    product_count DESC;


/* Is Sorusu:
   Urun kategorisine gore ortalama urun agirligi nedir?
*/
SELECT
    product_category_name,
    AVG(TRY_CAST(product_weight_g AS DECIMAL(18,2))) AS average_product_weight
FROM df_Products
GROUP BY
    product_category_name
ORDER BY
    average_product_weight DESC;


/* Is Sorusu:
   Hangi saticilar en yuksek urun satis gelirini olusturmustur?
*/
SELECT
    seller_id,
    SUM(price) AS total_product_sales
FROM df_OrderItems
GROUP BY
    seller_id
ORDER BY
    total_product_sales DESC;


/* Is Sorusu:
   Hangi saticilar en yuksek toplam kargo ucretini olusturmustur?
*/
SELECT
    seller_id,
    SUM(shipping_charges) AS total_shipping_charges
FROM df_OrderItems
GROUP BY
    seller_id
ORDER BY
    total_shipping_charges DESC;


/* Is Sorusu:
   Saticiya gore ortalama urun satis fiyati nedir?
*/
SELECT
    seller_id,
    AVG(price) AS average_product_price
FROM df_OrderItems
GROUP BY
    seller_id
ORDER BY
    average_product_price DESC;


/* Is Sorusu:
   Saticiya gore kac satis kalemi vardir?
*/
SELECT
    seller_id,
    COUNT(*) AS total_order_items
FROM df_OrderItems
GROUP BY
    seller_id
ORDER BY
    total_order_items DESC;


/* Is Sorusu:
   Urun fiyat segmentine gore kac satis kalemi vardir ve ne kadar urun geliri olusmustur?

   Not:
   Fiyat segmentleri satislarin dusuk, orta veya yuksek fiyat araliklarinda
   yogunlasip yogunlasmadigini gormek icin kullanilir.
*/
SELECT
    CASE
        WHEN price >= 0 AND price < 50 THEN '0-50'
        WHEN price >= 50 AND price < 200 THEN '50-200'
        WHEN price >= 200 AND price < 1000 THEN '200-1000'
        ELSE '1000+'
    END AS price_segment,
    COUNT(*) AS total_order_items,
    SUM(price) AS total_product_revenue,
    AVG(price) AS average_product_price
FROM df_OrderItems
GROUP BY
    CASE
        WHEN price >= 0 AND price < 50 THEN '0-50'
        WHEN price >= 50 AND price < 200 THEN '50-200'
        WHEN price >= 200 AND price < 1000 THEN '200-1000'
        ELSE '1000+'
    END
ORDER BY
    total_product_revenue DESC;


/* Is Sorusu:
   Minimum, maksimum ve ortalama odeme tutari nedir?

   Not:
   Bu sorgu, CASE WHEN ile anlamli odeme segmentleri belirlemeden once
   verinin genel araligini anlamaya yardim eder.
*/
SELECT
    MIN(payment_value) AS min_payment_value,
    MAX(payment_value) AS max_payment_value,
    AVG(payment_value) AS avg_payment_value
FROM df_Payments;


/* Is Sorusu:
   Odeme tutari segmentine gore kac odeme islemi vardir?

   Not:
   Segmentler MIN, MAX ve AVG degerleri kontrol edildikten sonra secilmelidir.
*/
SELECT
    CASE
        WHEN payment_value >= 0 AND payment_value < 50 THEN '0-50'
        WHEN payment_value >= 50 AND payment_value < 100 THEN '50-100'
        WHEN payment_value >= 100 AND payment_value < 200 THEN '100-200'
        WHEN payment_value >= 200 AND payment_value < 500 THEN '200-500'
        ELSE '500+'
    END AS payment_value_segment,
    COUNT(*) AS payment_count
FROM df_Payments
GROUP BY
    CASE
        WHEN payment_value >= 0 AND payment_value < 50 THEN '0-50'
        WHEN payment_value >= 50 AND payment_value < 100 THEN '50-100'
        WHEN payment_value >= 100 AND payment_value < 200 THEN '100-200'
        WHEN payment_value >= 200 AND payment_value < 500 THEN '200-500'
        ELSE '500+'
    END
ORDER BY
    payment_count DESC;

