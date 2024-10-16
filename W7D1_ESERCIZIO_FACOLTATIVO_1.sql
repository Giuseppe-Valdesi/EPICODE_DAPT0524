/*WD71_ESERCIZIO_FACOLTATIVO_1_1
1. Fai un Elenco di tutte le tabelle
2. Visualizza le prime 10 righe della tabella Album
3. Trova il numero totale delle canzoni della tabella Track
4. Trova i diversi Generi presenti nella tabella Genere*/

-- rinominanata tabella del genere
rename table genre to genere

 --1. Elenco di tutte le tabelle presenti nel DB
 
 show tables
 
 --2. della tabella album mostra le prime 10 righe
 
 select*
 from album
 limit 10;
 
 --3. conta il numero delle canzoni con diverse nome 3247 inferiore a 3503 il totale dei records
 
 select count(distinct Name) as Num_Canzoni
 from Track
 
--4. Mostra i diversi generi

  select name
  from genere;
  
  --5. PER AVERE LE CHIAVI PRIMARIE PER OGNI TABELLA
  
  SELECT 
    table_name, 
    column_name
  FROM 
    information_schema.key_column_usage
  WHERE
     constraint_name='primary'
     and table_schema= 'chinook';
     
/*WD71_ESERCIZIO_FACOLTATIVO_1_2
1. Recupera il nome di tutte le tracce e del genere associato*/

/* mostra tutte le tracce con il loro genere associato o meno*/
select t.Name
, g.Name
, t.TrackId
from track as t
left join genere as g
on t.GenreId=g.GenreId
order by t.TrackId desc;


/* mostra solo le tracce il cui nome si ripete più volte ed il numero di volte in cui si ripetono*/

select count(Name) as conteggio
, Name
from track
group by Name
having count(*) > 1
order by conteggio desc;

/*WD71_ESERCIZIO_FACOLTATIVO_1_3
  Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?*/
  
  -- restituisce tutti gli album ... eventualmente anche quelli che non hanno associato alcun artista 347 --
  Select
  album.Title
  , artist.Name
  from album
  left join artist
  on album.ArtistId=artist.ArtistId;
 
  -- conta il numero di album presenti nel database album totale 347 --
  select count(AlbumId)
  from album;
  
  -- restituisce dalla join precedente i valori nulli per artista = 0 ... per cui ad ogni album è associato un artista--
  Select
  album.Title
  , artist.Name
  from album
  left join artist
  on album.ArtistId=artist.ArtistId
  where name is null;
  
  -- La query sottostante è relativa ad una join fatta partendo dalla tabella artisti ...  e restituisce in 71 casi valori nulli
 -- per il campo album ... questo significa che nel totale di 418 artisti presenti nella Join (alcuni che si ripetono) nel db 
 -- ben 71 non hanno alcun album --
  
  Select
  artist.Name
  , album.Title
  from artist
  left join album
  on artist.ArtistId=album.ArtistId
  where title is null;
  
  /* La query sottostante mi raggruppa per ogni artista e mi conta il numero di album realizzati ordinandoli da n a 0/*/
  
    Select
  artist.Name
, count(album.Title) as n_album
  from artist
  left join album
  on artist.ArtistId=album.ArtistId
  group by artist.Name
  order by n_album desc;
  
/*WD71_ESERCIZIO_FACOLTATIVO_1_4
  Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della
  tipologia di media ?*/
  -- La query sottostante attraverso delle Join tra le tabelle 'track' - 'genere' e 'MediaType' - consente di recuperare il nome 
  della traccia il genere associatp e la tipologia di media --
  
  select TrackId
  , t.Name
  , g.Name
  , m.Name
  from track as t
  left join genere as g
  on t.GenreId=g.GenreId
  inner join mediatype as m
  on t.MediaTypeId=m.MediaTypeId;
  
 /*WD71_ESERCIZIO_FACOLTATIVO_1_5
  Elencate i nomi di tutti gli artisti e dei loro album*/
  -- Facciamo una Left Join tra 'Artist' ed 'Album' utilizzando come chiave ArtistID --
  
  select artist.Name
  , Title
  from artist
  left join album
  on artist.ArtistId=album.AlbumId
  order by Name asc;
  
  
  
  
  
  



  