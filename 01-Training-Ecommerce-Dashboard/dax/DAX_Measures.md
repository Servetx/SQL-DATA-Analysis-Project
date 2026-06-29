# DAX Measures

Bu dosya, Training E-Commerce Dashboard projesinde kullanilan DAX olculerini icerir.

## Core KPI Measures

```dax
Customers =
DISTINCTCOUNT(facteCommerce[Customer ID])

Orders =
COUNTROWS(facteCommerce)

Sales  =
SUM(facteCommerce[Total Sale Amount])

AOV =
DIVIDE(
    [Sales],
    [Orders]
)
```

## Previous Month and Growth Measures

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

## Country Sales Percentage

Ulke bazli satis oranini hesaplamak icin kullanilmistir.

```dax
Country Sales % =
VAR _allvalue =
    CALCULATE(
        [Sales],
        ALL(dimCountry)
    )
RETURN
    DIVIDE([Sales], _allvalue)
```

## Continent Rounded Bar Chart

Kita bazli satis oranini SVG bar chart olarak gostermek icin kullanilmistir.

```dax
Continent Rounded Bar Chart =
VAR W =
    ROUND([Country Sales %] * 500, 0)

VAR Pct =
    FORMAT([Country Sales %], "0.0%")

RETURN
    "data:image/svg+xml;utf8,"
        & "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 270 40'>"
        & "<rect x='0' y='8' width='" & W & "' height='24' rx='12' ry='12' fill='#2196F3' />"
        & "<text x='" & (W + 10) & "' y='26' font-size='28' fill='black'>"
        & Pct
        & "</text>"
        & "</svg>"
```

## Highlighted Month Details

Secili aylarin toplam satis icindeki oranini dinamik metin olarak gostermek icin kullanilmistir.

```dax
Highlighted Month Details =
VAR _selected_months =
    VALUES('Month Param'[Month Param])

VAR _selected_months_Sales =
    CALCULATE(
        [Sales],
        'Calendar'[Monthnum] IN _selected_months
    )

VAR _percent_of_total =
    FORMAT(
        DIVIDE(
            _selected_months_Sales,
            [Sales],
            0
        ),
        "percent"
    )

VAR _result =
    IF(
        ISFILTERED('Month Param'[Month Param]),
        "Highlighted months Sales : "
            & FORMAT(_selected_months_Sales, "#,0,,.00 Mi ( ")
            & _percent_of_total
            & " ) in Total Sales "
            & FORMAT([Sales], "#,0,,.00 Mi"),
        "Total Sales : "
            & FORMAT([Sales], "#,0,,.00 Mi")
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
