/* 1. Scrivi una query per verificare che il campo productkey nella tabella dimporduct sia una chiave primaria.
 Quali considerazioni/ragionamenti è necessario che tu faccia? 
 E' NECESSARIO CHE FACENDO IL RAGGRUPPAMENTO DI PRODUCT KEY ... CIASCUN VALORE APPAIA SOLO 1 VOLTA. INOLTRE OTTERRO' LO STESSO NUMERO DI RIGHE 
 DELLA TABELLA DIMPRODUCT*/
 
 SELECT ProductKey
 ,count(productkey) as conteggio
 FROM dimproduct
 group by ProductKey;
 
 /* La query mi restituisce n° 606 righe = alle righe della tabella dimproduct ... inoltre a rafforzare la dimostrazione ogni campo productkey
 si ripete solo una volta*/
 
 /* 2. scrivi una query per verificare che la combinazione dei campi Salesordernumber e Saleslineordernumber sia una PK*
 AFFINCHE' LA COMBINAZIONE DEI CAMPI SIA UNA PK ANCHE QUI IL CONTEGGIO DEL RAGGRUPPAMENTO DEI VALORI CONCATENATI DEVE RESTITUIRMI AD OGNI RECORD
 IL VALORE 1 PER TUTTI I RECORDS ... CIOE' CI DEVE ESSERE UNIVOCITA'*/
 
 
select
concat(SalesOrderNumber,SalesOrderLineNumber) as Linea_Ordine
, count(concat(SalesOrderNumber,SalesOrderLineNumber)) as conteggio
from factresellersales
group by concat(SalesOrderNumber,SalesOrderLineNumber);

/* 3. Conta il numero di transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020
La query mi deve restituire per ogni singolo giorno successivo a partire dal 01 Gennaio 2020 il numero delle transazioni. Anche qui 
usiamo una raggrupamento per giorno dove andiamo a contare il numero delle transazioni, ma avendo prima filtrato i records con una 
Where che mi restituisca i records successivi => al 01.01.2020*/

Select
OrderDate
, count(SalesOrderLineNumber)
from factresellersales
where year(OrderDate)>2019
group by OrderDate;

/* 4.Calcola il fatturato totale (FactresellerSales.SalesAmount), la quantità totale venduta (FactResellerSalesOrderQuantity) e il prezzo medio di 
vendita (FactResellerSales.UnitPrice) per prodotto (DimPorduct) a partire dal 01.Gennaio 2020. Il result deve esporre pertanto il nome del 
prodotto, il fatturato totale, la quantità totale venduta, e il prezzo medio di vendita. I campi in output devono essere parlanti!
Visto che la query deve esporre anche il nome bisogna fare una Inner Join .... per il resto occorre filtrare le vendite a far data dal 
01.01.2020 e creare il raggruppamento per productKey che consentirà poi di fare le diverse operazioni richieste sulla select
relativamente ai diversi campi....*/

Select dimproduct.ProductKey
, EnglishProductName
, sum(SalesAmount) as Totale_Fatturato
, sum(OrderQuantity) as Totale_Quantità
, avg(UnitPrice) as Prezzo_Medio
from factresellersales
inner join dimproduct
on factresellersales.ProductKey=dimproduct.ProductKey
where year(ShipDate)>2019
Group by ProductKey;

/* 5.Calcola il fatturato totale (FactResellerSalesAmount) e la quantità totale venduta(FactResellerSales.OrderQuantity) per Categoria di 
prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale 
venduta. I campi in output devono essere parlanti.
In questo caso oltre che avere risultati relativi alle vendite, dobbiamo raggruppare alcuni campi della tabella delle vendite per un campo non 
presente in questa tabella ossia la categoria. Si recupera questa informazione facendo delle Join
Da questa macrotabella da cui si recupera la categoria facendo il raggurppamento per categoria possiamo calcolare il totale delle
vendite e delle quantità vendute per categoria */

select
cat.ProductCategoryKey
, cat.EnglishProductCategoryName
, sum(s.SalesAmount) as Fatturato
, sum(OrderQuantity) as Quantità_Venduta
from factresellersales as s
inner join dimproduct as p
on s.ProductKey=p.ProductKey
left outer join dimproductsubcategory as sub
on p.ProductSubcategoryKey=sub.ProductSubcategoryKey
left outer join dimproductcategory as cat
on sub.ProductCategoryKey=cat.ProductCategoryKey
group by cat.ProductCategoryKey;

/* 6. Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre
l'elenco delle città con fatturato realizzato superiore a 60 K 
In questo caso le tabelle da mettere iinsieme con le join sono 3 ... factresellersale - dimSalesTerritory - dimGeography 
Opportunamente fatte le Join si deve fare un raggruppamento per città filtrando il risultato del fatturato per valori superiori a 60.000
... in realtà nessuna città ha fatturato meno di 60.000 per cui il valore sarà 562 righe*/


Select 
g.City
, sum(SalesAmount) as Fatturato_x_Citta
from factresellersales as s
left outer join dimsalesterritory as t
on s.SalesTerritoryKey=t.SalesTerritoryKey
inner join dimgeography as g
on t.SalesTerritoryKey=g.SalesTerritoryKey
where year(ShipDate) > 2019
group by City
having sum(SalesAmount)>60000;



SalesTerritoryKey






 
 
