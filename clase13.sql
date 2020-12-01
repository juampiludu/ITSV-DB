-- Add a new customer
-- 	To store 1
-- 	For address use an existing address. The one that has the biggest address_id in 'United States'

INSERT INTO sakila.customer
(store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES(1, 'Yo', 'Soy', 'yosoy@gmail.com', (select address_id
											from address
											inner join city using(city_id)
											inner join country using(country_id)
											where country.country = 'United States'
											group by address_id
											order by address_id desc
											limit 1), 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

select * from customer inner join address using (address_id) inner join city using (city_id) inner join country using(country_id) where first_name='Yo'
										
-- forma bien hecha

INSERT INTO customer
(store_id, first_name, last_name, email, address_id, active, create_date, last_update)
SELECT 1, 'ALICE', 'SMITH', 'test@domain.com', MAX(address_id), 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP FROM address
		INNER JOIN city USING (city_id)
		INNER JOIN country USING (country_id)
		WHERE country = 'United States';

-- Add a rental
-- 	Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
-- 	Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
-- 	Select any staff_id from Store 2.

INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES(CURRENT_TIMESTAMP, (select inventory_id
							from inventory
							inner join film using(film_id)
							where film.title = 'AIRPLANE SIERRA'
							group by film.film_id), 50, '2020-06-29 22:53:30.0', (select staff_id
																from staff
																inner join store on staff_id=store.manager_staff_id
																where store.store_id=2), CURRENT_TIMESTAMP);

-- Update film year based on the rating
-- 	For example if rating is 'G' release date will be '2001'
-- 	You can choose the mapping between rating and year.
-- 	Write as many statements are needed.

UPDATE film set 
	release_year = 2001
where rating = "G";

UPDATE film set 
	release_year = 2002
where rating = "NC-17";

UPDATE film set 
	release_year = 2003
where rating = "PG-13";

UPDATE film set 
	release_year = 2004
where rating = "R";

-- -------------------------------------------------

UPDATE film 
	SET release_year = (CASE
		WHEN rating = 'PG' THEN 2001
		WHEN rating = 'G' THEN 2002
		WHEN rating = 'NC-17' THEN 2003
		WHEN rating = 'PG-13' THEN 2004
		WHEN rating = 'R' THEN 2005
		ELSE release_year
	END)
WHERE rating IN ('PG', 'G', 'NC-17', 'PG-13', 'R');

-- Return a film
-- 	Write the necessary statements and queries for the following steps.
-- 	Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
-- 	Use the id to return the film.

set @inven_id = (select inventory.inventory_id
from film
inner join inventory using(film_id)
left join rental using (inventory_id)
where return_date is null
and rental_date in (select rental_date from rental order by rental_date desc)
limit 1);

UPDATE sakila.rental
SET return_date=date_add(current_timestamp, interval 7 day) , last_update=CURRENT_TIMESTAMP
WHERE inventory_id=@inven_id;

-- test
select * from inventory left join rental using(inventory_id) where inventory_id = 2047

-- Try to delete a film
-- 	Check what happens, describe what to do.
-- 	Write all the necessary delete statements to entirely remove the film from the DB.

-- cuando se intenta borrar un film, da error diciendo que necesitas borrar todos los ids de todas las tablas donde está referenciada
-- esa pelicula.

DELETE FROM film_actor
WHERE film_id=(select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM film_category
WHERE film_id=(select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM rental
WHERE inventory_id in (select inventory_id from inventory where inventory_id 
					in (select inventory_id from inventory where film_id=(select film_id from film where title='ACADEMY DINOSAUR')));

DELETE FROM inventory
WHERE film_id = (select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM film
WHERE title='ACADEMY DINOSAUR';

-- Rent a film
-- 	Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
-- 	Add a rental entry
-- 	Add a payment entry
-- 	Use sub-queries for everything, except for the inventory id that can be used directly in the queries.

set @randomId = (select inventory.inventory_id 
from rental
left join inventory using(inventory_id)
where return_date is not null
order by inventory.inventory_id desc
limit 1)

INSERT INTO rental
(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values (CURRENT_TIMESTAMP, @randomId, (select customer_id from customer order by customer_id desc limit 1), 
		date_add(current_timestamp, interval 7 day), (select staff_id from staff limit 1), CURRENT_TIMESTAMP);
	
INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date, last_update)
VALUES((select customer_id from customer order by customer_id desc limit 1), (select staff_id from staff limit 1), 
		(select rental.rental_id 
			from rental
			left join inventory using(inventory_id)
			where return_date is not null
			limit 1), 140.49, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);