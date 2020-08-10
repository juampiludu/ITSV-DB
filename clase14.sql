-- 1

select concat_ws(" ", first_name, last_name) as customer_name, address.address, city.city
from customer
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country.country like "%Argentina%"


-- 2

select title, lang.name, rating, (case 
									when rating = 'G' then "(General Audiences) – All ages admitted."
									when rating = 'PG' then "(Parental Guidance Suggested) – Some material may not be suitable for children."
									when rating = 'PG-13' then "(Parents Strongly Cautioned) – Some material may be inappropriate for children under 13."
									when rating = 'R' then "(Restricted) – Under 17 requires accompanying parent or adult guardian."
									when rating = 'NC-17' then "(Adults Only) – No one 17 and under admitted."
									else "No rating" end) as rating_description
from film
join `language` as lang using(language_id)


-- 3

select concat_ws(" ", actor.first_name, actor.last_name) as actor_name, film.title, film.release_year 
from actor
join film_actor using(actor_id)
join film using(film_id)
having actor_name like "%ed man%"

-- 4

select concat_ws(" ", customer.first_name, customer.last_name) as customer_name, film.title, (case when return_date is null then "No" else "Yes" end) as was_returned
from rental
join inventory using(inventory_id)
join film using(film_id)
join customer using(customer_id)
where month(rental_date) between 4 and 7

-- 5

-- the differnce between cast and convert is that convert allows to use a style for formatting data
-- the other difference is that cast is part of ansi-sql and convert is not



