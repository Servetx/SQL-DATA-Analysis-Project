/* =============================================================
   TEMEL SQL SORGULARI VE FİLTRELEME PRATİKLERİ
   ============================================================= */

/* 1. Müşteri Tablosundan Tüm Sütunları Seçiyoruz */
SELECT *
FROM df_Customers;

-- NEDEN BÖYLE YAZDIK?: 
-- Tabloda hangi sütunlar var, veriler nasıl görünüyor ilk bakışta topluca incelemek için '*' kullandık.


/* 2. İlk 10 Müşterinin Sadece ID Bilgisini Çağrıyoruz */
SELECT TOP 10 customer_id
FROM df_Customers;

-- NEDEN BÖYLE YAZDIK?: 
-- Tablonun tamamını çekip sistemi yormamak için 'TOP 10' ile sınırı koyduk. 
-- Gereksiz sütunları çağırmayıp sadece 'customer_id' alanını seçerek performansı koruduk.


/* 3. İlk 10 Şehri Alfabetik Olarak (A'dan Z'ye) Sıralayarak Getiriyoruz */
SELECT TOP 10 customer_city
FROM df_Customers
ORDER BY customer_city ASC;

-- NEDEN BÖYLE YAZDIK?: 
-- 'ORDER BY' kullanarak şehir isimlerini A'dan Z'ye sıraladık. 
-- Sıralama yapmazsak SQL bize rastgele 10 şehir getirirdi, bu sayede düzenli bir liste aldık.


/* 4. Belirli Bir Şehirdeki ('abaete') Müşterileri ve ID Bilgilerini Filtreliyoruz */
SELECT customer_city, customer_id
FROM df_Customers
WHERE customer_city = 'abaete';

-- NEDEN BÖYLE YAZDIK?: 
-- 'WHERE' komutuyla filtre koyduk. Sistemdeki binlerce şehir arasından sadece ismi tam olarak 'abaete' olanları ayıkladık.


/* 5. AND Bağlacı İle Hem Eyaleti 'SP' Hem de Şehri 'abaete' Olanları Listeliyoruz */
SELECT customer_city, customer_state
FROM df_Customers
WHERE customer_state = 'SP' AND customer_city = 'abaete';

-- NEDEN BÖYLE YAZDIK?: 
-- 'AND' (Ve) kullanarak nokta atışı yaptık. Sadece iki şartı birden aynı anda sağlayan müşterileri ekrana getirdik.


/* 6. Şehir Adı 'A' veya 'a' Harfi İle BİTEN Yerleri Bulur */
SELECT customer_city
FROM df_Customers
WHERE customer_city LIKE '%A';

-- NEDEN BÖYLE YAZDIK?: 
-- 'LIKE' kelimesi metinlerin içinde arama yapmayı sağlar. 
-- Başına koyduğumuz '%' işareti, "öncesinde ne yazarsa yazsın önemli değil, yeter ki en son harfi A olsun" demektir.


/* 7. Sadece 'SP', 'RJ' veya 'MG' Eyaletlerindeki Müşterileri Getirir */
SELECT customer_state
FROM df_Customers
WHERE customer_state IN ('SP', 'RJ', 'MG');

-- NEDEN BÖYLE YAZDIK?: 
-- Eğer 'IN' kullanmasaydık, yan yana bir sürü "OR customer_state = 'SP' OR customer_state = 'RJ'..." yazıp kodu uzatacaktık. 
-- 'IN' operatörü, parantez içine yazdığımız listeyi tek seferde filtreleyerek kodu kısaltır ve bilgisayarı yormez.


/* 8. Tablodaki Tüm Benzersiz (Tekrarlanmayan) Fiyatları Listeler */
SELECT DISTINCT price
FROM df_OrderItems;

-- NEDEN BÖYLE YAZDIK?: 
-- Mağazada aynı fiyata satılan yüzlerce ürün olabilir. 
-- 'DISTINCT' kelimesi aynı olan tüm fiyatları ayıklar, her fiyattan ekrana sadece 1 tane bastırır. Böylece sistemdeki farklı fiyat tiplerini net görürüz.
