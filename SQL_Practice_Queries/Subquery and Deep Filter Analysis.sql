/* =============================================================
   SUBQUERY AND FILTERING PRACTICE
   ============================================================= */

-- En yüksek sipariş tutarına sahip müşterinin ID bilgisini getirir.
SELECT 
    CustomerID
FROM Customers
WHERE CustomerID = (
    SELECT 
        CustomerID
    FROM Orders
    WHERE Amount = (
        SELECT 
            MAX(Amount)
        FROM Orders
    )
);
