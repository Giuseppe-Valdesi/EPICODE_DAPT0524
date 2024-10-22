/* ... Esercizio 1 Effettuate un’esplorazione preliminare del database. Di cosa si tratta? 
Quante e quali tabelle contiene? Fate in modo di avere un’idea abbastanza chiara riguardo a con cosa state lavorando...*/

show tables;
 -- ci sono 23 tabelle -- 
/* 'actor'
'actor_info'
'address'
'category'
'city'
'country'
'customer'
'customer_list'
'film'
'film_actor'
'film_category'
'film_list'
'film_text'
'inventory'
'language'
'nicer_but_slower_film_list'
'payment'
'rental'
'sales_by_film_category'
'sales_by_store'
'staff'
'staff_list'
'store'
*/

/* ... Esercizio 2 Scoprite quanti clienti si sono registrati nel 2006.... 599 Clienti*/
SELECT 
    COUNT(customer_id) n_clienti, YEAR(create_date) AS anno
FROM
    customer
GROUP BY YEAR(create_date);


/* ... Esercizio 3 Trovate il numero totale di noleggi effettuati il giorno 01/01/2006....non ci sono noleggi per questo giorno*/
SELECT 
    rental_date
FROM
    rental
WHERE
    DATE(rental_date) = '2006-01-01';

/* ... Esercizio 4 Elencate tutti i film noleggiati nell'ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati*/
select
DATE(rental.rental_date) as data_noleggio
,customer.customer_id
,customer.first_name
, customer.last_name
, customer.active
,customer.email
from rental
INNER JOIN customer
ON rental.customer_id=customer.customer_id
WHERE rental_date between '2005-07-05 00:00:00' AND '2005-12-05 23:59:59';

/* ... Esercizio 5 Calcolate la durata media del noleggio per ogni categoria di film*/
select
c.name
, avg(datediff(return_date,rental_date)) as giorni_prestito
from rental as r
inner join inventory as i
on r.inventory_id=i.inventory_id
inner join film_category as fc
on i.film_id=fc.film_id
inner join category as c 
on fc.category_id=c.category_id
group by c.name
order by giorni_prestito desc;

/* ... Esercizio 6 Trovate la durata media del noleggio più lungo*/

select
max(timediff(return_date,rental_date)) as durata_noleggio
from rental;



select*
from(select
r.customer_id
, c.last_name
,max(timediff(return_date,rental_date)) as durata_noleggio
from rental r
inner join customer c
on r.customer_id=c.customer_id
group by r.customer_id order by durata_noleggio desc) as d
limit 1