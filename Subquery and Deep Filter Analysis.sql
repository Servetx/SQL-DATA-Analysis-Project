/* =============================================================
   SUBQUERY AND DEEP FILTER ANALYSIS (İÇ İÇE SORGULAR)
   ============================================================= */

SELECT CustomerID
FROM Customers
WHERE CustomerID = (
    SELECT CustomerID
    FROM Orders
    WHERE Amount = (SELECT MAX(Amount) FROM Orders)
);

-- NEDEN BÖYLE YAZDIK?: 
-- İç içe üç sorgu (Subquery) kullanarak; önce en yüksek tekil sipariş tutarını bulduk, 
-- sonra bu siparişi veren müşterinin ID'sine ulaştık ve en dıştaki sorguyla bu kişiyi 
-- nokta atışı filtrelemek için kullandık.
