create database `restaurant_db`;
use restaurant_db ;

create table products(
	id int auto_increment primary key,
    `name` varchar(30) not null unique,
	`type` varchar(30) not null,
	price decimal(10,2) not null
);

create table clients(
	id int auto_increment primary key ,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birthdate date not null,
	card varchar(50),
    review text
);

create table `tables`(
	id int auto_increment primary key, 
	floor int not null,
	reserved tinyint(1),
	capacity int not null
);


create table waiters(
	id int auto_increment primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null, 
	email varchar(50) not null,
	phone varchar(50),
	salary decimal(10,2)
    
);

create table orders(
	id int auto_increment primary key,
	table_id int not null ,
	waiter_id int not null,
	order_time time not null,
	payed_status tinyint(1),
	constraint fk_waiter_id
    foreign key (waiter_id) references waiters(id),
    constraint fk_table_id
    foreign key (table_id) references `tables`(id)
);

create table orders_clients(
	order_id int,
	client_id int,
    constraint fk_order_id
    foreign key (order_id) references orders(id),
    constraint fk_client_id
    foreign key (client_id) references clients(id)
);
create table orders_products(
	order_id int,
	product_id int,
    constraint fk_orders_id
    foreign key (order_id) references orders(id),
	constraint fk_product_id
    foreign key (product_id) references products(id)
);

#2

insert into products (`name`, `type`, price)
select
    lower(substring(reverse(`name`), 1,char_length(`name`)-1)),
    id as rating,
    leader_id * 1000 as budget,
    id as team_id
from teams
where id between 1 and 9 ;

insert into products (`name`, `type`, price)
select concat(last_name, ' specialty') as `name`,
       'Cocktail' as `type`,
       ceil(salary * 0.01) as price
from waiters 
where id > 6;


#3
update orders
set table_id = table_id - 1
where id >=12 and id<=23;

#4
 delete from waiters
 where id not in (select waiter_id from orders);
 
 #5
 select id	,first_name	,last_name	,birthdate,	card,	review 
 from clients
 order by birthdate desc , id desc;
 
 #6
 select  first_name, last_name, birthdate , review 
 from clients
 where card is null
 and birthdate between '1978-01-01' and '1993-12-31'
 order by last_name desc , id asc limit 5;
 
 #7
 select 
	concat(last_name , first_name ,length(first_name),'Restaurant') as username,
    reverse(substring(substring(email, 2, 12), 1, 12)) as `password`
 from waiters
 where salary is not null
 order by `password` desc;
 
 #8
select p.id, p.`name`, count(product_id) as `count`
from products p
join orders_products op
on op.product_id = p.id
group by product_id
having `count` >=5
order by `count` desc ,`name` asc;

#9
select 
	t.id ,	
	t.capacity,	
	count(oc.client_id) as count_clients,	
	case 
		when t.capacity > count(oc.client_id)  then "Free seats"
        when  t.capacity = count(oc.client_id) then "Full"
        when  t.capacity < count(oc.client_id)  then "Extra seats"
	end as availability 
from `tables`t
join orders o
on o.table_id = t.id
join orders_clients oc
on oc.order_id = o.id
where floor = 1
group by order_id
order by table_id desc;

#10

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50)) 
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_bill DECIMAL(10,2);

    SELECT SUM(p.price) INTO total_bill
    FROM clients c
    JOIN orders_clients oc ON oc.client_id = c.id
    JOIN orders_products op ON op.order_id = oc.order_id
    JOIN products p ON p.id = op.product_id
    WHERE CONCAT(c.first_name, ' ', c.last_name) = full_name
    GROUP BY CONCAT(c.first_name, ' ', c.last_name);

    RETURN total_bill;
END$$


#11
DELIMITER $$
create procedure udp_happy_hour (`type` VARCHAR(50))
begin
	update  products p
	set price = price * 0.8
	where price >= 10 and p.`type` = `type`;
end



