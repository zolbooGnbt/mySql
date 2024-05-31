create database `lab1-minions`;
use `lab1-minions`;

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

alter table towns
rename column town_id to id;

alter table minions
add column town_id int;

alter table minions
add foreign key (town_id) references towns(id);

insert into minions
values (1, 'Kevin', 22,1);







