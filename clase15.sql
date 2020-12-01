-- 1

create view list_of_customers as
	select 
		customer.customer_id, 
		concat_ws(" ", customer.first_name, customer.last_name) as full_name, 
		address.address, 
		address.postal_code, 
		address.phone,
		city.city,
		country.country,
		(case when customer.active = 1 then "active" else "inactive" end) as active,
		store.store_id
	from customer
	join address using(address_id)
	join city using(city_id)
	join country using(country_id)
	join store using(store_id)
	
select * from list_of_customers

-- 2

create view film_details as 
	select
		film.film_id, 
		film.title, 
		film.description, 
		category.name, 
		film.`length`,
		group_concat(concat_ws(", ", concat_ws(" ", actor.first_name, actor.last_name))) as cast
	from film
	join film_category using(film_id)
	join category using(category_id)
	join film_actor using(film_id)
	join actor using(actor_id)
	group by film.film_id
	
	
select * from film_details


-- 3

create view sales_by_film_category as
	select 
		category_id, 
		name, 
		count(rental.rental_id) as total_rental
	from category
	join film_category using(category_id)
	join film using(film_id)
	join inventory using(film_id)
	join rental using(inventory_id)
	group by category_id
	
select * from sales_by_film_category
	

-- 4

create view actor_information as
	select actor.actor_id, first_name, last_name, count(film_actor.film_id) as films_acted_on
	from actor
	join film_actor using(actor_id)
	group by actor.actor_id

select * from actor_information



-- 5

select * from actor_info


-- 6

















	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			