/* =============================================================
   CTE MANAGEMENT AND TOTAL SALES (WITH PRATİĞİ)
   ============================================================= */

WITH Toplamlar AS (
    SELECT CustomerID, SUM(Amount) AS Toplam_Miktar
    FROM Orders
    GROUP BY CustomerID
)
SELECT C.CustomerName, T.Toplam_Miktar
FROM Customers C
JOIN Toplamlar T ON C.CustomerID = T.CustomerID
ORDER BY Toplam_Miktar DESC;

-- NEDEN BÖYLE YAZDIK?: 
-- 'WITH' (CTE) kullanarak her müşterinin toplam harcamasını geçici bir tabloda topladık. 
-- Ana sorguda ise müşteri isimleriyle bu toplamları birleştirerek, şirkete en çok ciro 
-- kazandıran müşterileri büyükten küçüğe listelemek için kullandık.
