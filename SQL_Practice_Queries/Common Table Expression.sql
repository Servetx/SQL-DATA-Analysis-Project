/* =============================================================
   CTE AND CUSTOMER TOTAL SALES ANALYSIS
   ============================================================= */
 --CTE icinde musteriler ve siparisler birlestirilir
-- Her musteri icin toplam harcama tutari hesaplanir.
-WITH Toplamlar AS (
    SELECT 
        C.CustomerID,
        C.CustomerName,
        SUM(O.Amount) AS Toplam_Miktar
    FROM Customers C
    JOIN Orders O
        ON C.CustomerID = O.CustomerID
    GROUP BY 
        C.CustomerID,
        C.CustomerName
)
SELECT 
    CustomerName,
    Toplam_Miktar
FROM Toplamlar;
