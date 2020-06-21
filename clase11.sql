-- 4. Find all the film titles that are not in the inventory.

SELECT DISTINCT title
FROM film f, inventory i 
WHERE title NOT IN (SELECT DISTINCT title 
FROM film f2, inventory i2 
WHERE f2.film_id = i2.film_id)

-- 5. Find all the films that are in the inventory but were never rented.

--    - Show title and inventory_id.
--    - This exercise is complicated.
--    - hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null

SELECT title, inventory.inventory_id 
FROM film 
INNER JOIN inventory 
ON film.film_id = inventory.film_id
LEFT OUTER JOIN rental 
ON inventory.inventory_id = rental.inventory_id
WHERE rental_id IS NULL


-- 6. Generate a report with:

--    - customer (first, last) name, store id, film title,
--    - when the film was rented and returned for each of these customers
--    - order by store_id, customer last_name

SELECT first_name, last_name, inventory.store_id as 'store id', rental_date, return_date
FROM customer
INNER JOIN rental USING(customer_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
ORDER BY last_name, 'store id';

-- 7. Show sales per store (money of rented films)

--    - show store's city, country, manager info and total sales (money)
--    - (optional) Use concat to show city and country and manager first and last name

select staff.store_id, concat(city.city, ", ", country.country) as country, concat(staff.first_name, " ", staff.last_name), sum(amount) as "total sales"
from payment
inner join rental using(rental_id)
inner join inventory using(inventory_id)
inner join store using(store_id)
inner join address using(address_id)
inner join city using(city_id)
inner join country using(country_id)
inner join staff
where staff.staff_id=store.manager_staff_id
group by store_id


-- 8. Which actor has appeared in the most films?

select actor
from (select concat(first_name, " ", last_name) as actor, count(film_actor.actor_id) as total
		from actor 
		inner join film_actor using(actor_id) 
		group by actor_id
		order by total desc
		limit 1) as a



























