select * from wizzard_deposits; 
USE `ex4-gringotts`;

#1
select count(id)as count from wizzard_deposits;
select count(*) from wizzard_deposits;

#2
select max(magic_wand_size) as`longest_magic_wand` from wizzard_deposits;

#3
select  deposit_group , max(magic_wand_size) as `longest_magic_wand`  
from wizzard_deposits
group by deposit_group
order by  longest_magic_wand desc ,deposit_group ;

#4
select deposit_group from  wizzard_deposits
group by deposit_group
order by avg(magic_wand_size) 
limit 1;

-- select deposit_group
-- from (
--   select deposit_group, avg(magic_wand_size) as avg_wand_size
--   from wizzard_deposits
--   group by deposit_group
-- ) as sub
-- order by avg_wand_size asc
-- limit 1;

#5
select deposit_group , sum(deposit_amount) as `total_sum` from wizzard_deposits
group by deposit_group
order by total_sum asc;

#6
select deposit_group , sum(deposit_amount) as `total_sum` from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
order by deposit_group;

#7
select deposit_group , sum(deposit_amount) as total_sum from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having total_sum < 150000
order by total_sum desc;

#8
select deposit_group , magic_wand_creator , min(deposit_charge)as min_deposit_charge 
from wizzard_deposits
group by deposit_group , magic_wand_creator
order by magic_wand_creator , deposit_group;

#9
select case 
	when age between 0 and 10 then '[0-10]'
    when age <=20 then '[11-20]'
	when age <=30 then '[21-30]'
	when age <=40 then '[31-40]'    
    when age <=50 then '[41-50]'
	when age <=60 then '[51-60]'
    else '[61+]'
end as age_group, count(*) as wizard_count from wizzard_deposits
group by age_group
order by min(age);

#10
-- select distinct left(first_name,1) as first_letter from wizzard_deposits
-- where deposit_group = 'Troll Chest'
-- order by first_letter ;

select substring(first_name,1,1) as first_letter from wizzard_deposits
where deposit_group = 'Troll Chest'
group by first_letter
order by first_letter ;

-- select distinct substring(first_name,1,1) as first_letter from wizzard_deposits
-- where deposit_group = 'Troll Chest'
-- order by first_letter ;

#11
select deposit_group , is_deposit_expired ,  avg(deposit_interest) as `average_interest` from wizzard_deposits
where deposit_start_date > '1985-01-01'
group by deposit_group , is_deposit_expired
order by deposit_group desc , is_deposit_expired asc;


USE `ex4-soft_uni`;

#12
select department_id, min(salary) as minimum_salary from employees
where hire_date > '2000-01-01' and department_id in(2,5,7)
group by department_id
order by department_id asc;

select department_id, min(salary) as minimum_salary from employees
where hire_date > '2000-01-01'
group by department_id
having department_id in(2,5,7)
order by department_id asc;

#13
create table high_paid_employees as
select * from employees
where salary > 30000  ;

delete from high_paid_employees
where manager_id = 42;

update high_paid_employees
set salary = salary + 5000
where department_id = 1;

select department_id, avg(salary) as avg_salary from new_high_paid_employees
group by department_id
order by department_id asc;

#14
select department_id, max(salary) as max_salary from employees
group by  department_id
having max_salary not between 30000 and 70000
order by department_id asc;

#15
select count(salary) from employees
where manager_id is null;

#16
-- select department_id ,salary from employees
-- order by department_id asc, salary desc;

select department_id, max(salary) as third_highest_salary
from (
    select department_id, salary, dense_rank() over (partition by department_id order by salary desc) as salary_rank
    from employees
) ranked_salaries
where salary_rank = 3
group by department_id
order by department_id;


#17
select first_name , last_name , department_id from employees
where salary > (
	select avg(e.salary) 
    from employees e
    where department_id = e.department_id
)
order by department_id , employee_id limit 10;


#18
select department_id , sum(salary) as total_salary from employees
group by department_id
order by department_id;