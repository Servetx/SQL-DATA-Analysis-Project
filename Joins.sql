
/* =================================================================================
   SQL JOIN PRACTICES AND TABLE RELATION ANALYSIS
   ================================================================================= */


/* ---------------------------------------------------------------------------------
   1. INNER JOIN
   --------------------------------------------------------------------------------- */

-- Tüm ilişkili tablolarda eşleşen satış kayıtlarını getirir.
SELECT
    c.customer_id,
    c.customer_city,
    oi.price,
    o.order_status,
    p.payment_value,
    ps.product_category_name
FROM df_customers AS c
JOIN df_orders AS o 
    ON c.customer_id = o.customer_id
JOIN JOIN df_OrderItems AS oi  AS oi 
    ON o.order_id = oi.order_id
JOIN df_payments AS p
    ON oi.order_id = p.order_id
JOIN df_products AS ps 
    ON oi.product_id = ps.product_id;


/* ---------------------------------------------------------------------------------
   2. LEFT JOIN
   --------------------------------------------------------------------------------- */

-- Tüm müşterileri listeler, sipariş veya ürün bilgisi varsa eşleştirir.
-- Siparişi olmayan müşteriler de sonuçta görünür.
SELECT
    c.customername,
    c.city,
    p.productname,
    o.amount
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.customerid = o.customerid
LEFT JOIN products AS p
    ON o.productid = p.productid;


/* ---------------------------------------------------------------------------------
   3. FULL JOIN
   --------------------------------------------------------------------------------- */

-- Müşteri, sipariş ve ürün tablolarındaki tüm kayıtları getirir.
-- Eşleşmeyen kayıtlar NULL değerlerle birlikte listelenir.
SELECT
    c.customername,
    c.city,
    o.amount,
    p.category,
    p.productname
FROM customers AS c
FULL JOIN orders AS o
    ON c.customerid = o.customerid
FULL JOIN products AS p 
    ON o.productid = p.productid;


/* ---------------------------------------------------------------------------------
   4. RIGHT JOIN
   --------------------------------------------------------------------------------- */

-- Sağdaki orders/products tarafındaki kayıtları koruyarak müşteri bilgilerini eşleştirir.
-- Müşteri bilgisi eksik olsa bile sipariş/ürün kayıtları sonuçta görünür.
SELECT
    c.customername,
    c.city,
    o.amount,
    p.category,
    p.productname
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customerid = o.customerid
RIGHT JOIN products AS p 
    ON o.productid = p.productid;
```
