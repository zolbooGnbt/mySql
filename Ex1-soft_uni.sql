use soft_uni1;

#13
create table towns(
id int(10) not null auto_increment primary key,
`name` varchar(50) not null);

insert into towns
values(1,London),(2,Rome),(3, Paris),(4, Amsterdam);

create table `addresses` (
  `id`int(10) not null auto_increment primary key,
  `address_text` varchar(100) not null,
  `town_id` int(10) default null   UNIQUE KEY
);

create table `departments` (
  `id`int(10) not null auto_increment primary key,
  `name` varchar(50) not null,
  `manager_id` int(10) not null,
UNIQUE KEY `PK_Departments` (`id`),
  KEY `fk_departments_employees` (`manager_id`),
  CONSTRAINT `fk_departments_employees` FOREIGN KEY (`manager_id`) REFERENCES `employees` (`employee_id`)
) 

#14
select * from towns;
select * from departments;
select* from employees;

#15
select * from towns
order by `name` asc;
select * from departments
order by `name` asc;
select	* from employees
order by salary desc;

#16
select `name` from towns
order by `name` asc;
select `name` from departments
order by `name` asc;
select	first_name, last_name, job_title, salary from employees
order by salary desc;

#17
update employees
set salary = salary * 1.10;
select salary from employees;
