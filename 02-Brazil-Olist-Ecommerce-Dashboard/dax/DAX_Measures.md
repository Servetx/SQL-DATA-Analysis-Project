# DAX Measures

Bu dosya, Brazil Olist E-Commerce Dashboard projesinde kullanilan temel DAX olculerini icerir.

## Core KPI Measures

Dashboard'daki temel KPI kartlarini hesaplamak icin kullanilmistir.  
Customers musteri sayisini, Orders siparis sayisini, Payment Value toplam odeme tutarini, AOV ise ortalama siparis degerini gosterir.

```dax
Customers =
DISTINCTCOUNT(df_Customers[customer_id])

Orders =
COUNTROWS(df_Orders)

Payment Value =
SUM(df_Payments[payment_value])

AOV =
DIVIDE(
    [Payment Value],
    [Orders]
)
```

## Previous Month and Growth Measures

KPI kartlarinda onceki ay degeri, buyume orani ve pozitif/negatif renk bilgisini gostermek icin kullanilmistir.
```dax
AOV PM =
CALCULATE(
    [AOV],
    PREVIOUSMONTH('Calendar'[Date])
)

AOV Growth =
DIVIDE(
    [AOV] - [AOV PM],
    [AOV PM]
)

AOV Color =
IF(
    [AOV Growth] >= 0,
    "Green",
    "Red"
)
```

Ayni Previous Month, Growth ve Color mantigi Customers, Orders ve Payment Value KPI kartlari icin de uygulanmistir.

## Highlighted Month Details

Secili aylarin toplam satis icindeki oranini dinamik metin olarak gostermek icin kullanilmistir.

```dax
Highlighted Month Details =
VAR _selected_months =
    VALUES('Month Param'[Month Param])

VAR _selected_months_PaymentValue =
    CALCULATE(
        [Payment Value],
        'Calendar'[Monthnum] IN _selected_months
    )

VAR _percent_of_total =
    FORMAT(
        DIVIDE(
            _selected_months_PaymentValue,
            [Payment Value],
            0
        ),
        "percent"
    )

VAR _result =
    IF(
        ISFILTERED('Month Param'[Month Param]),
        "Highlighted months Payment Value: "
            & FORMAT(_selected_months_PaymentValue, "#,0,,.00 Mi ( ")
            & _percent_of_total
            & " ) in Payment Value "
            & FORMAT([Payment Value], "#,0,,.00 Mi"),
        "Payment Value : "
            & FORMAT([Payment Value], "#,0,,.00 Mi")
    )

RETURN
    _result
```

## Month Highlight Color

Secilen aylari grafikte farkli renkle gostermek icin kullanilmistir.

```dax
Month Highlight Color =
VAR _selected_months =
    VALUES('Month Param'[Month Param])

VAR _result =
    IF(
        ISFILTERED('Month Param'[Month Param])
            && MAX('Calendar'[Monthnum]) IN _selected_months,
        "#FF8310",
        "#4063FF"
    )

RETURN
    _result
```
## Month Switch

Ay numarasini kisa ay adina cevirmek icin kullanilmistir.


```dax
Month Switch =
SWITCH(
    SELECTEDVALUE('Month Param'[Month Param]),
    1, "Jan",
    2, "Feb",
    3, "Mar",
    4, "Apr",
    5, "May",
    6, "Jun",
    7, "Jul",
    8, "Aug",
    9, "Sep",
    10, "Oct",
    11, "Nov",
    12, "Dec"
)
```
## Previous Month

KPI kartlarinda onceki ay bilgisini dinamik olarak gostermek icin kullanilmistir.

```dax
Previous Month =
VAR myPrevMonth =
    CALCULATE(
        SELECTEDVALUE('Calendar'[Month]),
        PREVIOUSMONTH('Calendar'[Date])
    )

RETURN
    "vs. " & myPrevMonth & ":"
```

## Calendar Table

Tarih bazli analizler, onceki ay karsilastirmalari ve ay filtreleri icin kullanilan takvim tablosudur.

```dax
Calendar =
ADDCOLUMNS(
    CALENDARAUTO(),
    "Year", YEAR([Date]),
    "Month", FORMAT([Date], "mmm", "en-US"),
    "Monthnum", MONTH([Date]),
    "Day", DAY([Date]),
    "Weekday", FORMAT([Date], "ddd"),
    "Weeknum", WEEKDAY([Date]),
    "Qtr", "Q- " & FORMAT([Date], "Q"),
    "Weektype", IF(
        WEEKDAY([Date]) = 1 || WEEKDAY([Date]) = 7,
        "Weekend",
        "Weekday"
    )
)
