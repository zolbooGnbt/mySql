create database `ex1-minions`;
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


