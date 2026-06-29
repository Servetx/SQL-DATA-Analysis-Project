
/* =============================================================
   ORDER ITEM METRICS AND CUSTOMER SPENDING ANALYSIS
   Dataset: Olist Brazil E-Commerce
   ============================================================= */

-- Sipariş kalemi seviyesinde toplam kayıt sayısını kontrol eder.
SELECT 
    COUNT(*) AS Total_Order_Items
FROM df_OrderItems;

-- Sipariş kalemleri üzerinden toplam ürün satış tutarını hesaplar.
SELECT 
    SUM(Price) AS Total_Item_Sales
FROM df_OrderItems;


-- Ürün fiyat aralığını görmek için en düşük fiyat değerini getirir.
SELECT 
    MIN(Price) AS Min_Item_Price
FROM df_OrderItems;


-- Ürün fiyat aralığını görmek için en yüksek fiyat değerini getirir.
SELECT 
    MAX(Price) AS Max_Item_Price
FROM df_OrderItems;


-- Sipariş kalemleri bazında ortalama ürün fiyatını hesaplar.
SELECT 
    AVG(Price) AS Avg_Item_Price
FROM df_OrderItems;


-- Müşteri bazında toplam ürün harcamasını hesaplar.
-- Customers, Orders ve OrderItems tabloları müşteri-sipariş-ürün ilişkisini kurmak için birleştirildi.
SELECT 
    C.customer_id,
    SUM(OI.Price) AS Total_Customer_Spending
FROM df_Customers C
JOIN df_Orders O
    ON C.customer_id = O.customer_id
JOIN df_OrderItems OI
    ON O.order_id = OI.order_id
GROUP BY 
    C.customer_id
ORDER BY 
    Total_Customer_Spending DESC;
```
