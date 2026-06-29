
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
FROM df_Customers C
JOIN df_Orders O 
ON c.customer_id = o.customer_id
JOIN df_OrderItems oi
ON o.order_id = oi.order_id
JOIN df_Payments P
ON oi.order_id = p.order_id
JOIN df_Products ps
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
FROM customers c
LEFT JOIN orders o 
    ON c.CustomerID = o.CustomerID
LEFT JOIN products p
    ON o.ProductID = p.ProductID;


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
FROM customers c
FULL JOIN orders o
    ON c.CustomerID = o.CustomerID
FULL JOIN products p 
    ON o.ProductID = p.ProductID;


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
FROM customers c
RIGHT JOIN orders o
    ON c.CustomerID = o.CustomerID
RIGHT JOIN products p 
    ON o.ProductID = p.ProductID;
