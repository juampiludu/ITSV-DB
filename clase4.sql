-- 1. Show title and special_features of films that are PG-13

SELECT title, special_features
FROM film f
WHERE rating = 'PG-13'

-- 2. Get a list of all the different films duration.

SELECT DISTINCT `length` 
FROM film f
WHERE `length` ORDER BY `length` ASC 

-- 3. Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00

SELECT title, rental_rate, replacement_cost
FROM film f 
WHERE replacement_cost BETWEEN 20 AND 24

-- 4. Show title, category and rating of films that have 'Behind the Scenes' as special_features

SELECT title, name, rating
FROM film f, category c
WHERE special_features = 'Behind the Scenes'

-- 5. Show first name and last name of actors that acted in 'ZOOLANDER FICTION'

SELECT first_name, last_name
FROM actor a, film f, film_actor fa
WHERE a.actor_id = fa.actor_id
AND f.film_id = fa.film_id
AND title = 'ZOOLANDER FICTION'

-- 6. Show the address, city and country of the store with id 1

SELECT address, city, country, s.address_id
FROM address a, city c, country c2, store s
WHERE s.address_id = a.address_id
AND a.address_id = 1
AND c.city_id = a.city_id 
AND c2.country_id = c.country_id 

-- 7. Show pair of film titles and rating of films that have the same rating.



-- 8. Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).

SELECT title, first_name, last_name
FROM film f, store s, staff s2
WHERE s.address_id = 2
AND s.manager_staff_id = s2.staff_id 
AND s.store_id = s2.store_id 