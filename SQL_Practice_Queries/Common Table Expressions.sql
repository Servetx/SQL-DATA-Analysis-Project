/* =============================================================
   CTE AND CUSTOMER TOTAL SALES ANALYSIS
   ============================================================= */

-- Her müşterinin toplam harcamasını CTE içinde hesaplar.
WITH Toplamlar AS (
    SELECT 
        CustomerID,
        SUM(Amount) AS Toplam_Miktar
    FROM Orders
    GROUP BY 
        CustomerID
)

-- CTE sonucunu müşteri bilgileriyle birleştirir.
-- Müşteriler toplam harcama tutarına göre büyükten küçüğe sıralandı.
SELECT 
    C.CustomerName,
    T.Toplam_Miktar
FROM Customers C
JOIN Toplamlar T
    ON C.CustomerID = T.CustomerID
ORDER BY 
    T.Toplam_Miktar DESC;
