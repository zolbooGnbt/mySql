CREATE DATABASE IF NOT EXISTS `lab4-restaurant`;
use `lab4-restaurant`	;

CREATE TABLE departments (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	department_id INT NOT NULL,
	salary DOUBLE NOT NULL,
	CONSTRAINT fk_department_id FOREIGN KEY(`department_id`) REFERENCES departments(`id`)
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE  products (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	category_id INT NOT NULL,
	price DOUBLE NOT NULL,
	CONSTRAINT fk_cateogory_id FOREIGN KEY(`category_id`) REFERENCES categories(`id`)
);

INSERT INTO departments(name) VALUES ("Management"), ("Kitchen Staff"), ("Wait Staff");

INSERT INTO employees (first_name, last_name, department_id, salary) VALUES ("Jasmine","Maggot",2,1250.00), 
("Nancy","Olson",2,1350.00), ("Karen","Bender",1,2400.00), ("Pricilia","Parker",2,980.00),
("Stephen","Bedford",2,780.00),("Jack","McGee",1,1700.00),("Clarence","Willis",3,650.00),
("Michael","Boren",3,780.00),("Michael","Boren",3,780.00);

INSERT INTO categories(name) VALUES("salads"),("appetizers"),("soups"),("main"),("desserts");

INSERT INTO products (name, category_id,price) VALUES ("Lasagne", 4,12.99),
("Linguine Positano with Chicken", 4,11.69),
("Chicken Marsala", 4,13.69),
("Calamari", 2,14.89),
("Tomato Caprese with Fresh Burrata", 2,7.99),
("Wood-Fired Italian Wings", 2,9.90),
("Caesar Side Salad", 1,8.79),
("House Side Salad", 1,6.79),
("Johny Rocco Salad", 1,6.90),
("Minestrone", 3,8.89),
("Sausage & Lentil", 3,7.90),
("Mama Mandola’s Sicilian Chicken Soup", 3,6.90),
("Tiramisú", 5,4.90),
("John Cole", 5,5.60),
("Mini Cannoli", 5,5.60);


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