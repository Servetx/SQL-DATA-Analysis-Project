/* =============================================================
   E-TICARET IS ODAKLI SQL ANALIZI
   Dosya: 02_Business_Join_Analysis.sql
   Konu: JOIN ile is analizi
   Veritabani: SQL Server

   Amac:
   Musteri, siparis, urun, odeme ve satici tablolarini birlestirerek
   daha gercekci is sorularina cevap vermek.

   Kullanilacak tablolar:
   - df_Customers
   - df_Orders
   - df_OrderItems
   - df_Payments
   - df_Products

   Temel iliskiler:
   - df_Customers.customer_id = df_Orders.customer_id
   - df_Orders.order_id = df_OrderItems.order_id
   - df_Orders.order_id = df_Payments.order_id
   - df_OrderItems.product_id = df_Products.product_id
   ============================================================= */


/* Is Sorusu 1:
   Siparisleri musteri bilgileriyle birlikte listele.

   Amac:
   Her siparisin hangi musteriye, sehre ve eyalete ait oldugunu gormek.
*/
SELECT
    o.order_id,
    o.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at
FROM df_Orders o
JOIN df_Customers c
    ON o.customer_id = c.customer_id;


/* Is Sorusu 2:
   Siparis kalemlerini urun kategori bilgisiyle birlikte listele.

   Amac:
   Her satilan urunun hangi kategoriye ait oldugunu gormek.
*/
SELECT
    oi.order_id,
    oi.product_id,
    p.product_category_name,
    oi.seller_id,
    oi.price,
    oi.shipping_charges,
    p.product_weight_g,
    p.product_height_cm,
    p.product_width_cm
FROM df_OrderItems oi
JOIN df_Products p
    ON oi.product_id = p.product_id;


/* Is Sorusu 3:
   Odeme bilgilerini siparis bilgileriyle birlikte listele.

   Amac:
   Her siparisin odeme tipi, taksit sayisi ve odeme tutarini gormek.
*/
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_approved_at,
    pay.payment_type,
    pay.payment_installments,
    pay.payment_sequential,
    pay.payment_value
FROM df_Orders o
JOIN df_Payments pay
    ON o.order_id = pay.order_id;


/* Is Sorusu 4:
   Eyalete gore toplam urun satis geliri nedir?

   Amac:
   Hangi eyaletlerin daha fazla urun geliri olusturdugunu analiz etmek.
*/
SELECT
    c.customer_state,
    SUM(oi.price) AS total_product_revenue
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    total_product_revenue DESC;


/* Is Sorusu 5:
   Urun kategorisine gore toplam urun satis geliri nedir?

   Amac:
   Hangi urun kategorilerinin daha fazla gelir olusturdugunu analiz etmek.
*/
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_product_revenue
FROM df_Products p
JOIN df_OrderItems oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_product_revenue DESC;


/* Is Sorusu 6:
   Musteri bazinda toplam urun harcamasi nedir?

   Amac:
   En yuksek urun harcamasi yapan musterileri bulmak.
*/
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    SUM(oi.price) AS total_product_expenditure
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_city,
    c.customer_state
ORDER BY
    total_product_expenditure DESC;


/* Is Sorusu 7:
   Odeme tipine gore toplam urun satis geliri nedir?

   Amac:
   Hangi odeme tipleriyle gelen siparislerin daha fazla urun geliri olusturdugunu analiz etmek.
*/
SELECT
    pay.payment_type,
    SUM(oi.price) AS total_product_revenue
FROM df_Payments pay
JOIN df_OrderItems oi
    ON pay.order_id = oi.order_id
GROUP BY
    pay.payment_type
ORDER BY
    total_product_revenue DESC;


/* Is Sorusu 8:
   Sehir ve kategori bazinda toplam urun satis geliri nedir?

   Amac:
   Hangi sehirlerde hangi kategorilerin daha fazla gelir olusturdugunu analiz etmek.
*/
SELECT
    c.customer_city,
    p.product_category_name,
    SUM(oi.price) AS total_product_revenue
FROM df_Customers c
JOIN df_Orders o
    ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
    ON o.order_id = oi.order_id
JOIN df_Products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_city,
    p.product_category_name
ORDER BY
    total_product_revenue DESC;
