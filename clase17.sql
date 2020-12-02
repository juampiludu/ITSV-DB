-- 1

select * 
from address 
where postal_code in (77948, 1027);
-- 4 ms

select * 
from address
join city using(city_id)
join country using(country_id);
-- 12 ms

drop index postalCode on address;
create index postalCode on address(postal_code);
-- 124ms



-- 2

select first_name
from actor;

select last_name
from actor;

-- Las diferencias estan en que los apellidos están ordenados alfabeticamente y los nombres no.
-- Esto pasa porque last_name tiene un index que los ordena ascendentemente.



-- 3

select description
from film
where description like '%Mexico%';

select title, description
from film_text
where match(title, description) against('Mexico');
-- Mi tabla film_text está vacía :(

-- Pero la diferencia está en que en la segunda está usando un full text index.
