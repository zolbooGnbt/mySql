#1
create table people (
	person_id int auto_increment primary key,
    first_name varchar(20),
    salary decimal(10,2),
    passport_id int not null
);

create table passports(
	passport_id int ,
    passport_number varchar(20),
    constraint fk_passport_id
    foreign key (passport_id) references people(person_id),
    unique (passport_number)
);

insert into people
values(1,'Roberto', 43300.00 ,102),(2,'Tom', 56100.00 ,103),(3,'Yana', 60200.00 ,101);

insert into passports
values(101, 'N34FG21B'),(102,'K65LO4R7'),(103 ,'ZE657QP2');
#2

create table manufacturers(
	manufacturer_id int not null auto_increment primary key,
    `name` varchar(50),
    established_on date
);

create table models(
	model_id int auto_increment not null primary key,
    `name` varchar(50),
    manufacturer_id int,
    constraint fk_manufacturer_id
    foreign key (model_id) references manufacturers(manufacturer_id)
);
