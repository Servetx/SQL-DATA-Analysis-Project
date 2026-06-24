```sql
/* =============================================================
   BASIC SQL QUERIES AND FILTERING PRACTICES
   Dataset: Olist Brazil E-Commerce
   ============================================================= */

-- Customers tablosundaki tüm verileri kontrol eder.
SELECT *
FROM df_Customers;


-- İlk 10 müşterinin customer_id bilgisini getirir.
SELECT TOP 10 
    customer_id
FROM df_Customers;


-- İlk 10 müşteri şehrini alfabetik olarak listeler.
SELECT TOP 10 
    customer_city
FROM df_Customers
ORDER BY 
    customer_city ASC;


-- Belirli bir şehirdeki müşterileri filtreler.
SELECT 
    customer_city,
    customer_id
FROM df_Customers
WHERE 
    customer_city = 'abaete';


-- Belirli şehir ve eyalet koşulunu birlikte filtreler.
SELECT 
    customer_city,
    customer_state
FROM df_Customers
WHERE 
    customer_state = 'SP'
    AND customer_city = 'abaete';


-- Şehir adı belirli bir harfle biten kayıtları getirir.
SELECT 
    customer_city
FROM df_Customers
WHERE 
    customer_city LIKE '%A';


-- Belirli eyaletlerdeki müşterileri listeler.
SELECT 
    customer_state
FROM df_Customers
WHERE 
    customer_state IN ('SP', 'RJ', 'MG');


-- OrderItems tablosundaki benzersiz fiyat değerlerini listeler.
SELECT DISTINCT 
    price
FROM df_OrderItems;
```

