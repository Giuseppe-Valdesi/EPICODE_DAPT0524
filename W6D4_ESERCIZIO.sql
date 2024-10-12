/* esercizio W6D4_ESERCIZIO_1*/
select
ProductKey,
EnglishProductName,
P.ProductSubcategoryKey,
sub.EnglishProductSubcategoryName
FROM dimproduct AS P
INNER JOIN dimproductsubcategory as sub 
on p.ProductSubcategoryKey=sub.ProductSubcategoryKey;

/* esercizio W6D4_ESERCIZIO_2*/
select
ProductKey,
EnglishProductName,
p.ProductSubcategoryKey,
sub.EnglishProductSubcategoryName,
cat.EnglishProductCategoryName
FROM dimproduct AS P
INNER JOIN dimproductsubcategory as sub 
on p.ProductSubcategoryKey=sub.ProductSubcategoryKey
INNER JOIN dimproductcategory as cat
on cat.ProductCategoryKey=sub.ProductCategoryKey;

/* esercizio W6D4_ESERCIZIO_3*/
select
p.ProductKey,
s.ProductKey,
EnglishProductName,
SalesAmount
FROM dimproduct AS P
INNER JOIN factresellersales as s
on p.ProductKey=s.ProductKey;

/* esercizio W6D4_ESERCIZIO_4*/
select
p.ProductKey,
s.ProductKey,
EnglishProductName,
FinishedGoodsFlag,
SalesAmount
FROM dimproduct AS P
LEFT outer JOIN factresellersales as s
on p.ProductKey=s.ProductKey
WHERE FinishedGoodsFlag=1 AND SalesAmount IS NULL;

/* esercizio W6D4_ESERCIZIO_5*/
select
p.ProductKey,
s.productkey,
EnglishProductName,
FinishedGoodsFlag,
SalesAmount
FROM factresellersales AS s
RIGHT outer join dimproduct as p
on s.ProductKey=p.ProductKey;

/* esercizio W6D4_ESERCIZIO_6*/
select
p.ProductKey,
c.EnglishProductCategoryName,
v.SalesAmount
from dimproduct as p
inner join dimproductsubcategory as s
on p.ProductSubcategoryKey=s.ProductSubcategoryKey
inner join dimproductcategory as c
on s.ProductCategoryKey=c.ProductCategoryKey
inner join factresellersales v
on p.ProductKey=v.ProductKey;

/* esercizio W6D4_ESERCIZIO_7*/
select*
from dimreseller;

/* esercizio W6D4_ESERCIZIO_8*/
select
ResellerName,
g.EnglishCountryRegionName
from dimreseller as r
left outer join dimgeography as g
on r.GeographyKey=g.GeographyKey;


/* esercizio W6D4_ESERCIZIO_9*/
select
SalesOrderNumber,
SalesOrderLineNumber,
OrderDate,
UnitPrice,
OrderQuantity,
TotalProductCost,
EnglishProductName,
EnglishProductCategoryName,
EnglishProductSubcategoryName,
dr.ResellerName,
EnglishCountryRegionName,
g.City,
g.StateProvinceName
from factresellersales as s
INNER join dimproduct as p
on s.ProductKey=p.ProductKey
INNER join dimproductsubcategory as sub
on p.ProductSubcategoryKey=sub.ProductSubcategoryKey
INNER join dimproductcategory as c
on c.ProductCategoryKey=sub.ProductCategoryKey
INNER join dimreseller as dr
on dr.ResellerKey=s.ResellerKey
INNER join dimgeography as g
on g.GeographyKey=dr.GeographyKey;




w6d4_esercizio