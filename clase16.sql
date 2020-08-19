-- 1

INSERT INTO employees
(employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES(1083, 'Williams', 'Marcus', 'x3461', Null, 1, 1002, 'VP Production');

-- sql da error, la columna email no puede ser nula.


-- 2

update employees set employeeNumber = employeeNumber - 20

-- todas las columnas employeeNumber cambiaron y su valor se resto en 20


update employees set employeeNumber = employeeNumber + 20

-- da error, este se encuentra en un valor duplicado de la columna employeeNumber


-- 3

alter table employees add age int

alter table employees add constraint age check (age between 16 and 70)


-- 4

-- the referencial identity between this three tables are actor_id and film_id, which can be used to
-- join tables without conflicts or corruption of data.


-- 5

alter table employees add lastUpdate date

delimiter $$
create trigger last_update_employee
	before update on employees
begin 
	update employees
	set lastUpdate = now();
end$$
delimiter ;


-- 6



select * from employees e 
select * from employees_audit ea 









