use `ex1-minions`;
 #1
create table minions(
id int not null auto_increment,
`name` varchar(50) not null,
age int ,
primary key (`id`)
);
create table towns(
town_id int not null auto_increment,
`name` varchar(50) not null,
primary key (`town_id`)
);

 #2
alter table minions
add column town_id int;
alter table minions
add foreign key (town_id) references towns(id);
 
#3
insert into `towns`
values(1,'London'),
(2,'Rome'),
(3,'Paris');

insert into `minions`
values
	(1,'Kevin',22,1),
	(2,'Bob',15,3),
	(3,'Steward',null,2);-- 

#4
truncate table minions;
select * from minions;

#5 
drop table minions;
drop table towns;

#6
create table people(
id int not null auto_increment,
`name` varchar(200) not null,
picture mediumblob,
height decimal(5,2),
weight decimal(5,2),
gender enum('f','m') not null,
birthdate date not null,
biography text,
 primary key(`id`));
 
insert into people
values 
	(1,'zolboo ganbat',null,1.62, 66, 'f', '1993-06-15','older sister'),
	(2,'ider ganbat',null,1.65, 66, 'f', '1998-12-08','middle sister'),
	(3,'misheel ganbat',null,1.70, 60, 'f', '2010-05-30','younger sister'),
	(4,'ariunaa geleg',null,1.58, 66, 'f', '1970-09-13','mom'),
	(5,'ganbat sodnombaljir',null,1.70, 90, 'm', '1969-07-02','dad');

#7
create table users(
id bigint not null auto_increment,
username varchar(30) not null,
`password` varchar(26) not null,
profile_picture mediumblob,
last_login_time datetime,
is_deleted boolean,
unique(username),
primary key (id)
);

insert into users
values
	(1,'zolbooGanbat','Zxcv1234',null,now(),false),
	(2,'iderGanbat','Zxcv1234',null,now(),false),
	(3,'misheelGanbat','Zxcv1234',null,now(),false),
	(4,'ariunaaGanbat','Zxcv1234',null,now(),false),
	(5,'ganbatSoso','Zxcv1234',null,now(),true);

#8
alter table users
drop primary key,
add constraint pk_users primary key (id,username);


#9
alter table users
modify last_login_time timestamp default now();

#10
alter table users 
drop primary key,
add constraint pk_users primary key(id),
add constraint uq_username unique (username);


use `ex1-Movies`;
#11
CREATE TABLE `directors` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(50) NOT NULL, 
    `notes` TEXT
); 
 
INSERT INTO `directors`(`director_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');
 
CREATE TABLE `genres` (
    `id` INT PRIMARY KEY AUTO_INCREMENT , 
    `genre_name` VARCHAR(20) NOT NULL,
    `notes` TEXT
);
 
INSERT INTO `genres`(`genre_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');
 
CREATE TABLE `categories` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(20) NOT NULL,
    `notes` TEXT
);
 
INSERT INTO `categories`(`category_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');
 
CREATE TABLE `movies` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(40) NOT NULL, 
    `director_id` INT,
    `copyright_year` INT,
    `length` INT,
    `genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE, 
    `notes` TEXT
);
 
INSERT INTO `movies` (`title`)
VALUES 
('TestMovie1'),
('TestMovie2'),
('TestMovie3'),
('TestMovie4'),
('TestMovie5');
 


use `ex1-car_rental`;
CREATE TABLE `categories` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `category` VARCHAR(20), 
    `daily_rate` DOUBLE, 
    `weekly_rate` DOUBLE, 
    `monthly_rate` DOUBLE, 
    `weekend_rate` DOUBLE    
);
 
INSERT INTO `categories` (`category`)
VALUES 
('TestName1'),
('TestName2'),
('TestName3');
 
CREATE TABLE `cars` (
    `id` INT PRIMARY KEY AUTO_INCREMENT, 
    `plate_number` VARCHAR(20),
    `make` VARCHAR(20),
    `model` VARCHAR(20),
    `car_year` INT,
    `category_id` INT,
    `doors` INT,
    `picture` BLOB,
    `car_condition` VARCHAR(30),
    `available` BOOLEAN   
);
 
INSERT INTO `cars` (`plate_number`)
VALUES 
('TestName1'),
('TestName2'),
('TestName3');
 
CREATE TABLE `employees` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `title` VARCHAR(50),
    `notes` TEXT
);
 
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES 
('TestName1', 'TestName1'),
('TestName2', 'TestName2'),
('TestName3', 'TestName3');
 
CREATE TABLE `customers` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `driver_license` VARCHAR(20),
    `full_name` VARCHAR(50),
    `address` VARCHAR(50),
    `city` VARCHAR(10),
    `zip_code` VARCHAR(10),
    `notes` TEXT
);
 
INSERT INTO `customers` (`driver_license`, `full_name`)
VALUES 
('TestName1', 'TestName1'),
('TestName2', 'TestName2'),
('TestName3', 'TestName3');
 
CREATE TABLE `rental_orders` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id` INT,
    `customer_id` INT,
    `car_id` INT,
    `car_condition` VARCHAR(50),
    `tank_level` VARCHAR(20),
    `kilometrage_start` INT,
    `kilometrage_end` INT,
    `total_kilometrage` INT,
    `start_date` DATE, 
    `end_date` DATE, 
    `total_days` INT,
    `rate_applied` DOUBLE,
    `tax_rate` DOUBLE,
    `order_status` VARCHAR(20),
    `notes` TEXT
);
 
INSERT INTO `rental_orders` (`employee_id`, `customer_id`)
VALUES 
(1, 2),
(2, 3),
(3, 1);


# Exercise 13 Basic Insert
INSERT INTO `towns` (`name`)
VALUES ("London"), ("Rome"), ("Paris"), ("Amsterdam");
 
INSERT INTO `departments` (`name`)
VALUES ("Engineering"), ("Sales"), ("Marketing"), ("Software Development"), ("Quality Assurance");
 
 
INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
VALUES
('Ignacio', 'Hamilton', 'Mcmillan', '.NET Developer', 4, '2013-02-01', 3500.00),
('Rudy', 'Hardy', 'Pike', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Meredith', 'Owens', 'Russo', 'Intern', 5, '2016-08-28', 525.25),
('Grady', 'Forbes', 'Stokes', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);


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
