USE `ex6-soft_uni`;

#1 join 2 table
select e.employee_id ,e.job_title, a.address_id , a.address_text 
from employees as e
join addresses as a
on e.address_id = a.address_id
order by address_id asc
limit 5;

#2 join 3 table
select e.first_name , e.last_name , t.`name` as town , a.address_text 
from employees as e
join addresses as a
on a.address_id = e.address_id
join towns as t
on t.town_id =  a.town_id
order by first_name , last_name limit 5;

#3
select e.employee_id ,e.first_name , e.last_name , d.`name` as department_name
from employees as e
join departments as d
on e.department_id = d.department_id
where d.`name` = 'Sales'
order by employee_id desc;

#4
select e.employee_id , e.first_name , e.salary , d.`name` as department_name
from employees as e
join departments as d
on d.department_id = e.department_id
where e.salary > 15000
order by d.department_id desc limit 5;

#5
select employee_id , first_name from employees
where employee_id not in (select e.employee_id from employees_projects as e)
order by employee_id desc limit 3;

#6
select e.first_name , e.last_name , e.hire_date , d.`name` as dept_name 
from employees as e
join departments as d
on d.department_id = e.department_id
where d.`name` in ('Sales', 'Finance') and e.hire_date >'1999-01-01'
order by hire_date asc;


#7
select e.employee_id , e.first_name , p.`name` as project_name 
from employees as e
inner join employees_projects as ep
on ep.employee_id = e.employee_id
inner join projects as p
on p.project_id = ep.project_id
where p.start_date > '2002-08-13' and p.end_date is null
order by e.first_name asc , p.`name` asc limit 5;

SELECT 
    e.`employee_id`,
    e.`first_name`,
    p.`name` AS 'project_name'
FROM
    `employees` AS e
        INNER JOIN
    `employees_projects` AS ep ON e.`employee_id` = ep.`employee_id`
        INNER JOIN
    `projects` AS p ON ep.`project_id` = p.`project_id`
WHERE
    p.`start_date` > '2002-08-13 23-59-59'
        AND p.`end_date` IS NULL
ORDER BY e.`first_name` , p.`name`
LIMIT 5;

#8
select e.employee_id , e.first_name , 
	case 
		when year(p.start_date) > 2004 then NULL 
		else p.`name`
	end as project_name
from employees as e
inner join employees_projects as ep
on ep.employee_id = e.employee_id
inner join projects as p
on p.project_id = ep.project_id
where e.employee_id like 24 
order by project_name asc;

select  
	e.employee_id , 
	e.first_name , 
	if(year(p.start_date) > 2004 ,NULL ,p.`name`) as project_name
from employees as e
inner join employees_projects as ep
on ep.employee_id = e.employee_id
inner join projects as p
on p.project_id = ep.project_id
where e.employee_id like 24 
order by project_name asc;

#9
select e.employee_id , e.first_name , e.manager_id , 
	(select mn.first_name from employees as mn
    where mn.employee_id = e.manager_id ) as manager_name
from employees as e 
where e.manager_id in (3,7)
order by e.first_name asc;

#10
select 
	e.employee_id  ,
    concat(e.first_name ,' ' , e.last_name) as employee_name , 
	concat(mn.first_name ,' ', mn.last_name) as manager_name,
    d.`name` as department_name
from employees as e
join employees as mn 
on mn.employee_id = e.manager_id
join departments as d
on e.department_id = d.department_id
order by e.employee_id limit 5;


#11
select min( t.avg_salary) 
from (  select avg(salary) as avg_salary 
		from employees as e
        group by e.department_id ) as t;

USE `ex6-geography`;

#12
select mc.country_code , m.mountain_range , p.peak_name, p.elevation 
from peaks as p
join mountains_countries as mc
on p.mountain_id = mc.mountain_id
join mountains as m
on m.id = mc.mountain_id
where country_code = 'BG' and p.elevation > 2835
order by p.elevation desc;

#13
select mc.country_code , count(m.mountain_range ) as mountain_range
from mountains as m
join mountains_countries as mc
on mc.mountain_id = m.id
where mc.country_code in( 'BG' ,'RU' ,'US')
group by country_code
order by mountain_range desc;


#14
select c.country_name , river_name 
from countries as c
left join countries_rivers as cr
on cr.country_code = c.country_code
left join rivers as r
on cr.river_id = r.id
where c.continent_code ='AF'
order by country_name asc limit 5;

#15
select c1.continent_code ,c1.currency_code ,c1.currency_usage 
from (
	select co.continent_code , cu.currency_code , count(c.currency_code) as currency_usage
    from continents as co
    join countries as c
    on c.continent_code = co.continent_code
    join currencies as cu
    on c.currency_code = cu.currency_code
    group by co.continent_code, cu.currency_code
    having currency_usage > 1
)as c1
join(
	select
        co_usage.continent_code,
		max(co_usage.currency_usage) as 'max_usage'
    from
        (select
			co.continent_code,
            cu.currency_code,
            count(c.currency_code) as 'currency_usage'
		from continents as co
		join countries as c on co.continent_code = c.continent_code
		join currencies as cu on c.currency_code = cu.currency_code
		group by co.continent_code , cu.currency_code
		having currency_usage > 1
        ) as co_usage
    group by co_usage.continent_code
    ) as c2 
on c1.continent_code = c2.continent_code
where c1.currency_usage = c2.max_usage
order by c1.continent_code , c1.currency_code;

#16
select count(c.country_code) as country_count 
from countries as c
left join mountains_countries as mc
on c.country_code = mc.country_code
where mc.mountain_id is null;

#17
select c.country_name , m.highest_peak_elevation , r.longest_river_length
from countries as c
join (
	select c.country_code , max(p.elevation) as highest_peak_elevation 
	from countries as c
    join mountains_countries as mc 
    on c.country_code = mc.country_code
    join peaks as p
    on mc.mountain_id = p.mountain_id
    group by country_code
    ) as m 
on c.country_code = m.country_code
join (
	select c.country_code , max(r.length) as longest_river_length
	from countries as c
    join countries_rivers as cr
    on c.country_code = cr.country_code
    join rivers as r
    on cr.river_id = r.id
    group by country_code
    ) as r 
on c.country_code = r.country_code
order by m.highest_peak_elevation desc, r.longest_river_length desc ,country_name asc
limit 5;

#15
select continent_code , currency_code , count(*) as count 
from countries as c1
group by continent_code , currency_code
having count > 1 
and count = (
	select count(*) as count from countries as c2
	where c1.continent_code = c2.continent_code 
	group by c2. currency_code 
    order by count desc
    limit 1)
order by continent_code , currency_code;

