/* =============================================================
   E-TICARET IS ODAKLI SQL ANALIZI
   Dosya: 03_Business_CTE_Analysis.sql
   Konu: CTE (WITH) ile is analizi
   Veritabani: SQL Server

   Amac:
   CTE kullanarak ara sonuc tablolari olusturmak ve bu sonuclari
   temiz bir dis SELECT ile raporlamak.

   Kullanilan SQL konulari:
   - WITH ile CTE olusturma
   - JOIN ile tablolar arasi iliski kurma
   - GROUP BY ile analiz seviyesini belirleme
   - SUM ile gelir ve tutar hesaplama
   - ORDER BY ile sonuclari siralama

   Not:
   CTE icindeki aliaslar sadece CTE icinde gecerlidir.
   Dis sorguda FROM kisminda verilen CTE aliasi kullanilir.
   ============================================================= */


/* Is Sorusu 1:
   Siparis bazinda urun geliri, kargo geliri ve toplam musteri odeme tutari nedir?
*/
WITH order_totals AS (
    SELECT
        order_id,
        SUM(price) AS total_product_revenue,
        SUM(shipping_charges) AS total_shipping_revenue,
        SUM(price) + SUM(shipping_charges) AS total_customer_paid_amount
    FROM df_OrderItems
    GROUP BY
        order_id
)
SELECT
    ot.order_id,
    ot.total_product_revenue,
    ot.total_shipping_revenue,
    ot.total_customer_paid_amount
FROM order_totals ot
ORDER BY
    ot.total_customer_paid_amount DESC;


/* Is Sorusu 2:
   Musteri bazinda toplam urun harcamasini hesapla.
   Sonucta musteri sehir ve eyalet bilgileri de gorunsun.
*/
WITH customer_totals AS (
    SELECT
        o.customer_id,
        SUM(oi.price) AS total_product_expenditure
    FROM df_Orders o
    JOIN df_OrderItems oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.customer_id
)
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    ct.total_product_expenditure
FROM df_Customers c
JOIN customer_totals ct
    ON c.customer_id = ct.customer_id
ORDER BY
    ct.total_product_expenditure DESC;


/* Is Sorusu 3:
   Eyalet bazinda toplam urun satis gelirini hesapla.
*/
WITH state_totals AS (
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
)
SELECT
    st.customer_state,
    st.total_product_revenue
FROM state_totals st
ORDER BY
    st.total_product_revenue DESC;


/* Is Sorusu 4:
   Kategori bazinda toplam urun satis gelirini hesapla.
*/
WITH category_totals AS (
    SELECT
        p.product_category_name,
        SUM(oi.price) AS total_product_revenue
    FROM df_Products p
    JOIN df_OrderItems oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_category_name
)
SELECT
    ct.product_category_name,
    ct.total_product_revenue
FROM category_totals ct
ORDER BY
    ct.total_product_revenue DESC;


/* Is Sorusu 5:
   Odeme turu bazinda toplam odeme tutarini hesapla.
*/
WITH payment_type_totals AS (
    SELECT
        p.payment_type,
        SUM(p.payment_value) AS total_payment_value
    FROM df_Payments p
    GROUP BY
        p.payment_type
)
SELECT
    pt.payment_type,
    pt.total_payment_value
FROM payment_type_totals pt
ORDER BY
    pt.total_payment_value DESC;


/* Is Sorusu 6:
   Satici bazinda toplam urun satis gelirini hesapla.
*/
WITH seller_totals AS (
    SELECT
        oi.seller_id,
        SUM(oi.price) AS total_product_revenue
    FROM df_OrderItems oi
    GROUP BY
        oi.seller_id
)
SELECT
    st.seller_id,
    st.total_product_revenue
FROM seller_totals st
ORDER BY
    st.total_product_revenue DESC;


/* Is Sorusu 7:
   Musteri bazinda toplam odeme tutarini hesapla.
*/
WITH customer_payment_totals AS (
    SELECT
        c.customer_id,
        SUM(p.payment_value) AS total_payment_value
    FROM df_Customers c
    JOIN df_Orders o
        ON c.customer_id = o.customer_id
    JOIN df_Payments p
        ON o.order_id = p.order_id
    GROUP BY
        c.customer_id
)
SELECT
    cpt.customer_id,
    cpt.total_payment_value
FROM customer_payment_totals cpt
ORDER BY
    cpt.total_payment_value DESC;


/* Is Sorusu 8:
   Sehir bazinda toplam urun satis gelirini hesapla.
*/
WITH city_totals AS (
    SELECT
        c.customer_city,
        SUM(oi.price) AS total_product_revenue
    FROM df_Customers c
    JOIN df_Orders o
        ON c.customer_id = o.customer_id
    JOIN df_OrderItems oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_city
)
SELECT
    ct.customer_city,
    ct.total_product_revenue
FROM city_totals ct
ORDER BY
    ct.total_product_revenue DESC;
