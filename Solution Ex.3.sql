use `ex3-soft_uni`;
#1
select first_name, last_name
from employees
where left(first_name, 2) = 'Sa'
order by employee_id;

#2
select first_name , last_name
from employees
where last_name like '%ei%'
order by employee_id;

#3
select first_name from employees
where department_id in (3, 10)
and year(hire_date) between 1995 and 2005
order by employee_id;

#4
select first_name , last_name from employees
where job_title not like '%engineer%'
order by employee_id;

#5
 select `name` from towns
 where length(`name`) in (5,6)
 order by `name` asc;
 
 #6
 select * from towns
 where left(`name`,1) in ('M','B','K','E')
 order by `name`;
 
 #7
 select * from towns
 where not left(`name`,1) in ('R','B','D')
 order by `name`;
 
 #8
 create view `v_employees_hired_after_2000` as
 select first_name , last_name from employees
 where year(hire_date) > 2000 ;
 select * from v_employees_hired_after_2000;
 
 #9
 select first_name , last_name from employees
 where  length(last_name) =5 ;
 
 #10
select country_name, iso_code from countries
where country_name like '%a%a%a%'
order by iso_code;

use `ex3-geography`;
#11
select p.peak_name,  r.river_name,lower(concat(p.peak_name, substring(r.river_name,2))) AS mix
from peaks p
join rivers r
on lower(right(p.peak_name, 1)) = lower(left(r.river_name, 1))
order by mix;


use `ex3-diablo`;
#12
select `name` ,  date_format(`start`, '%Y-%m-%d') from games
where year(`start`) in (2011,2012)
order by `start` , `name` limit 50;

#13
select user_name , substring_index(email ,'@', -1) as email_porvider 
from users
order by email_porvider , user_name;

#14 - wildcart
select user_name , ip_address from users
where ip_address like '___.1%.%.___'
order by user_name;

#15 - case shalgah
select
    `name` as game,
    case
        when extract(hour from `start`) >= 0 and extract(hour from `start`) < 12 then 'Morning'
        when extract(hour from `start`) >= 12 and extract(hour from `start`) < 18 then 'Afternoon'
        when extract(hour from `start`) >= 18 and extract(hour from `start`) < 24 then 'Evening'
	 end as 'Part of the Day',
    case
        when duration <= 3 then 'Extra Short'
        when duration <= 6 then 'Short'
        when duration <= 10 then 'Long'
        else 'Extra Long'
    end as duration
from games;


#16 - add date
select product_name , order_date, 
	date_add(order_date ,interval 3 day) as 'pay_due', 
    date_add(order_date,interval 1 month) as 'deliver_due' 
from orders;

