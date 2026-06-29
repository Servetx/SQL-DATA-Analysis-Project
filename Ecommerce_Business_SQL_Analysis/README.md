# E-Commerce Business SQL Analysis

Bu proje, e-ticaret veri seti uzerinde SQL Server ile hazirlanmis is odakli veri analizi calismasidir.

Amac sadece temel SQL komutlarini gostermek degil; musteri, siparis, urun, odeme, satici, gelir ve veri kalite kontrolleri gibi is sorularini SQL ile cevaplamaktir.

## Proje Konumu

Bu calisma gercek sirket deneyimi iddiasi tasimaz. Portfoy amacli bir vaka calismasidir.

Projenin hedefi:

- Is sorusunu SQL sorgusuna cevirebilmek
- Tablolar arasindaki iliskileri kullanmak
- Gelir, odeme ve musteri analizleri yapmak
- Veri kalite problemlerini kontrol etmek
- Okunabilir ve acik SQL dosyalari hazirlamak

## Kullanilan Tablolar

| Tablo | Aciklama |
| --- | --- |
| `df_Customers` | Musteri sehir ve eyalet bilgileri |
| `df_Orders` | Siparis ve musteri iliskisi |
| `df_OrderItems` | Urun, satici, fiyat ve kargo ucreti bilgileri |
| `df_Payments` | Odeme tipi, taksit sayisi ve odeme tutari |
| `df_Products` | Urun kategorisi ve urun olcu bilgileri |

## Dosyalar

| Dosya | Icerik |
| --- | --- |
| `00_Data_Preparation.sql` | Sayisal analiz icin veri tipi hazirligi ve product_weight_g temizligi |
| `01_Business_Aggregate_Analysis.sql` | COUNT, SUM, AVG, MIN, MAX, GROUP BY ve CASE WHEN ile temel is analizleri |
| `02_Business_Join_Analysis.sql` | Musteri, siparis, urun ve odeme tablolarini JOIN ile birlestiren analizler |
| `03_Business_CTE_Analysis.sql` | WITH / CTE kullanarak ara sonuc tablolari ile is analizleri |
| `04_Business_Window_Function_Analysis.sql` | ROW_NUMBER ile musteri, kategori, satici, odeme turu, sehir ve eyalet siralama analizleri |
| `05_Data_Quality_Checks.sql` | Tekrar eden ID, negatif tutar, bos kategori ve eslesmeyen kayit kontrolleri |

## Cevaplanan Is Sorulari

Bu projede asagidaki is sorularina SQL ile cevap verilmistir:

- Veri setinde kac siparis ve kac musteri vardir?
- En cok musteri hangi eyalet ve sehirlerdedir?
- Urun geliri, kargo geliri ve toplam musteri odeme tutari nedir?
- Odeme tipine gore toplam odeme tutari nedir?
- Hangi urun kategorileri en cok gelir getiriyor?
- Hangi saticilar en yuksek satis gelirini olusturuyor?
- Musteriler toplam harcamaya gore nasil siralaniyor?
- Sehir ve eyalet bazinda satis geliri nasil dagiliyor?
- Tekrar eden musteri veya siparis ID var mi?
- Fiyat, kargo ve odeme tutarlarinda hatali deger var mi?
- Urun kategorisi bos olan kayitlar var mi?
- Siparis ve siparis kalemleri ilgili ana tablolarla eslesiyor mu?

## Ornek Data Quality Bulgulari

Bu proje kapsaminda yapilan veri kalite kontrollerinde asagidaki bulgular elde edilmistir:

- `product_category_name` alaninda `NULL` kayit bulunmadi.
- `product_category_name` alaninda 308 kayit bos metin (`EMPTY_STRING`) olarak tespit edildi.
- `product_weight_g` alaninda sayisal tipe cevrilemeyen 15 kayit `NULL` olarak isaretlendi.
- Ortalama agirlik hesaplari gecerli, sayisal ve `NULL` olmayan agirlik degerleri uzerinden yapildi.

## Kullanilan SQL Konulari

- `COUNT`, `COUNT(DISTINCT)`
- `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY`, `HAVING`
- `CASE WHEN`
- `INNER JOIN`, `LEFT JOIN`
- `WITH` / CTE
- `ROW_NUMBER() OVER(...)`
- `WHERE`, `IS NULL`, bos metin kontrolu
- Data quality kontrolleri

## Not

Bu proje is odakli SQL portfoy calismasidir. Kodlar, temel SQL bilgisini gercekci is sorularina uygulama mantigiyla hazirlanmistir.
