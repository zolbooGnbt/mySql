SET SQL_SAFE_UPDATES = 0; 
# update delete needs key 
#--------------------------------------------------------------------------------------
use `lab2-hotel`;

select `id` , concat(`first_name`, ' ',`last_name`)as `full_name` ,`job_title`, `salary` 
from `employees` where salary > 1000.00;

SET SQL_SAFE_UPDATES = 0;

update `employees`
set `salary` = `salary` + 100
where `job_title`= 'Manager';

select salary from employees;

create view `v_top_paid_employee` as
select * from `employees`
order by `salary` desc limit 1;

select * from `v_top_paid_employee`;

select * from `employees` 
where (`department_id` = 4 and salary >= 1000 )
order by id;

delete from `employees`
where (`department_id`= 1 or `department_id`=2);

select * from `employees`
order by `id`;

#--------------------------------------------------------------------------------------

use `lab3-book_library`;
    
#1
select * from books;    
select title from books where
substring(title,1,3) = "The";

#2
select replace(title, 'The', '***') as title
from books
where title like 'The%'
order by id;

#3
select round(sum(cost),2) as total_price from books;

#4
select concat(first_name ,' ',last_name)as 'Full Name',
timestampdiff (day ,born, died) as 'Days Lived ' from authors;

#5
select title from books
where title like 'Harry Potter%';

#--------------------------------------------------------------------------------------
use `lab4-restaurant`;

#1
select e.`department_id` , count(department_id) as `Number of employees`
from employees as e
group by e.department_id
order by department_id;

#2
select e.`department_id` , round(avg(`salary`),2) as `Average Salary`
from employees as e
group by e.department_id;

#3
select e.`department_id` , round(min(e.`salary`),2) as `Min Salary`
from employees as e
group by e.department_id
having `Min Salary`> 800;

#4
select count(category_id) as `appetizers`
from products 
where category_id = 2 and price > 8;


#5
select `category_id` , round(avg(`price`),2) as `Average Price`,
round(min(`price`),2) as `Cheapest Product`,
round(max(`price`),2) as `Most Expensive Product` from products
group by category_id;
#--------------------------------------------------------------------------------------
use `lab5-camp`;
#1
create table Mountains(
	id int auto_increment  primary key,
    `name` varchar(50) not null
);

create table Peaks(
	id int auto_increment not null primary key,
    `name` varchar(50) not null,
    mountain_id int ,
    constraint pk_mountain_id 
    foreign key (mountain_id) references Mountains(id)
);

#2
select driver_id , vehicle_type , concat(first_name ,' ', last_name) as driver_name 
from campers as c
join vehicles as v
on v.driver_id = c.id;

#3
select 
	starting_point as route_starting_point ,
	end_point as route_ending_point , 
	leader_id ,
	concat(first_name ,' ', last_name) as leader_name 
from routes as r
join campers as c
on r.leader_id = c.id;


#4
drop table Mountains , Peaks; 

create table mountains(
	id int auto_increment  primary key,
    `name` varchar(50) not null
);

create table peaks(
	id int auto_increment not null primary key,
    `name` varchar(50) not null,
    mountain_id int ,
    constraint pk_mountain_id 
    foreign key (mountain_id) references mountains(id)
    on delete cascade
);

#5 

create table clients(
	id int(11) auto_increment primary key,
    client_name varchar(100)
);

create table projects(
	id int(11) auto_increment primary key,
    client_id int(11),
    project_lead_id int(11) unique,
    constraint fk_client_id 
    foreign key (client_id) references clients(id)
);

create table employees(
		id int(11) auto_increment primary key,
        first_name varchar(30),
        last_name varchar(30),
        project_id int(11),
        constraint fk_project_id 
        foreign key (project_id) references projects(id)
);

alter table projects
add constraint fk_project_employee
foreign key(project_lead_id) references employees(id);

#------------------------------------------------------------------------------------------------------------------------------

use `lab6-soft_uni`;

#1 join
select e.employee_id , concat(first_name ,' ' , last_name) as full_name , d.department_id, d.`name`
from employees as e
join departments as d
on e.employee_id = d.manager_id
order by e.employee_id limit 5;

#2 right join
select t.town_id , t.`name` , a.address_text  from addresses as a
join towns as t
on a.town_id = t.town_id
where t.`name` in( 'San Francisco','Sofia','Carnation' )
order by town_id , address_id;

#3 
select employee_id ,first_name , last_name , department_id , salary  from employees
where manager_id is null;

#4 subquery
select count(e.employee_id) as 'count' from employees as e
where e.salary > (select avg(salary) from employees);

#------------------------------------------------------------------------------------------------------------------------------

use `lab7-soft_uni`;

delimiter $$
create function ufn_count_employees_by_town(town_name varchar(50))
returns int
deterministic 
begin
	declare e_count int;
    set e_count := (
		select count(employee_id) from employees as e
        join addresses as a
        on e.address_id = a.address_id
        join towns as t
        on a.town_id = t.town_id
        where t.`name` = town_name );
    return e_count;
end$$

#2
delimiter $$
create procedure usp_raise_salaries(department_name varchar(50)) 
begin
	update  employees as e
    join departments as d
    on e.department_id = d.department_id
	set salary = salary * 1.05
    where d.`name` = department_name;
end$$


#3
delimiter $$
create procedure usp_raise_salary_by_id(id int) 
begin
	start transaction;
    if(
		select count(employee_id) from employees 
		where employee_id like id ) <> 1 then
	rollback;
    else
		update employees as e
		set salary = salary * 1.05 
        where e.employee_id = id ;
	end if;
end$$

#4

create table deleted_employees(
		employee_id int primary key auto_increment, 
		first_name varchar(50),
		last_name varchar(50),
		middle_name varchar(50),
		job_title varchar(50),
		department_id int,
		salary decimal(19,4));

create trigger tr_deleted_employees
before delete
on employees
for each row
begin
	insert into deleted_employees (first_name , last_name , middle_name , job_title , department_id , salary)
	values ( old.first_name, old.last_name , old.middle_name , old. job_tittle , old.department_id , old.salary);
end;