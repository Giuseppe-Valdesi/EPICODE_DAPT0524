/* W7D1_ESERCIZIO_FACOLTATIVO_2_1 Recuperate le tracce che abbiano genere "Pop" o "Rock" */
-- di seguito Query che attraverso left Join delle tabelle track e genere mi consente di filtrare per i generi Pop e Rock 
-- avendo restituite le singole tracce ed il loro genere -- sotto query per conteggio dei 2 raggruppamenti--
SELECT 
    track.Name, genere.Name
FROM
    track
        inner join
    genere ON track.GenreId = genere.GenreId
WHERE
    (genere.name = 'Pop')
        OR (genere.Name = 'Rock');


SELECT 
    COUNT(genere.Name), genere.Name
FROM
    track
        LEFT JOIN
    genere ON track.GenreId = genere.GenreId
GROUP BY genere.Name
HAVING genere.Name = 'Pop'
    OR genere.Name = 'Rock';

/* W7D1_ESERCIZIO_FACOLTATIVO_2_2 Elencate tutti gli artisti e/o gli album che iniziano con la lettera "A".*/

select 
Name
,Title
from artist
left join album
on artist.ArtistId=album.ArtistId
where artist.Name like 'A%' or album.Title like 'A%';


/* W7D1_ESERCIZIO_FACOLTATIVO_2_3 Elencate tutte le tracce che hanno come genere 'Jazz' o che durano meno di 3 minuti*/

SELECT 
    ROUND(track.milliseconds / 1000 / 60, 2),
    track.name AS nome_traccia,
    genere.Name AS genere
FROM
    track
        INNER JOIN
    genere ON track.GenreId = genere.GenreId
WHERE
    genere.Name = 'Jazz'
        OR track.Milliseconds < 18000
ORDER BY track.Milliseconds DESC;

/* W7D1_ESERCIZIO_FACOLTATIVO_2_4 Recuperate tutte le tracce più lunghe della durata media*/
-- Di seguito la Query che raggruppa per nome traccia e per ogni singola traccia mi filtra solo quelle che hanno una durata media superiore
-- alla media delle tracce ... questo viene fatto con una subquery all'interno della clausola having ---
-- ricordiamo che con il group by in select dobbiamo avere il campo per cui si è raggruoppato ed il valore frutto di una funzione di 
-- aggregazione riferito ad un campo coerente con il raggruppamento ... come se facessimo conta se o somma se ecc....--

SELECT 
    Name,
    AVG(ROUND(Milliseconds / 1000 / 60, 2)) AS media_traccia
FROM
    track
GROUP BY Name
HAVING AVG(ROUND(Milliseconds / 1000 / 60, 2)) > (SELECT 
        AVG(ROUND(Milliseconds / 1000 / 60, 2)) AS media
    FROM
        track)
ORDER BY media_traccia ASC;

-- la query sottostante riporta la media di tutte le tracce --
SELECT 
    AVG(ROUND(Milliseconds / 1000 / 60, 2)) AS media
FROM
    track;

--

/* W7D1_ESERCIZIO_FACOLTATIVO_2_5 Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.*/

SELECT
g.name
, avg(round(Milliseconds/1000/60, 2)) as durata_media_tracce
FROM
    track as t
        INNER JOIN genere as g 
        ON t.GenreId = g.GenreId
        group by g.Name
        having avg(round(Milliseconds/1000/60, 2))>4
        order by durata_media_tracce asc;
     
/* nella query sottostante vengono individuate i generi che hanno una durata media delle tracce inferiore a 4*/
        
SELECT
g.name
, avg(round(Milliseconds/1000/60, 2)) as durata_media_tracce
FROM
    track as t
        INNER JOIN genere as g 
        ON t.GenreId = g.GenreId
        group by g.Name
        having avg(round(Milliseconds/1000/60, 2))<4 
        order by durata_media_tracce asc;



/* W7D1_ESERCIZIO_FACOLTATIVO_2_6 Individuate gli artisti che hanno rilasciato più di un album.*/
select
a.Name
, count(b.Title) as N_Album
from artist as a
left join album as b
on a.ArtistId=b.ArtistId
group by a.Name 
having count(b.Title)>1
order by N_Album desc;


/* W7D1_ESERCIZIO_FACOLTATIVO_2_7 Trovate la traccia più lunga in ogni album*/



    SELECT 
     a.Title
     , max(Milliseconds)
    FROM
        album AS a
    INNER JOIN track AS t ON a.AlbumId = t.AlbumId
    group by a.Title;
    
    

/* W7D1_ESERCIZIO_FACOLTATIVO_2_8 Individuate la durata media delle tracce per ogni album.*/

select a.AlbumId
, a.Title
, avg(t.Milliseconds/1000/60) as durata_media_tracce
from track t
inner join album a
on a.albumid=t.AlbumId
group by a.AlbumId, a.Title;


/* W7D1_ESERCIZIO_FACOLTATIVO_2_9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in
 esso contenute.*/
 
 