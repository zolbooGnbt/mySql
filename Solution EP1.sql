create database sgd;
use sgd;

create table addresses(
	id int primary key auto_increment,
    `name` varchar(50) not null
);

create table categories(
	id int primary key auto_increment,
    `name` varchar(10) not null
);

create table offices(
	id int primary key auto_increment,
    workspace_capacity int not null, 
    website varchar(50) ,
    address_id int,
	constraint fk_address_id
    foreign key (address_id) references addresses(id)
);

create table employees(
	id int primary key auto_increment,
    `first_name` varchar(30) not null, 
    `last_name` varchar(30) not null, 
    age int not null,
    salary decimal(10,2) not null,
    job_title varchar(20) not null,
    happiness_level char(1) not null
);

create table teams(
	id int primary key auto_increment,
    `name` varchar(40) not null, 
    office_id int not null, 
    leader_id int not null unique,
	constraint fk_office_id
    foreign key (office_id) references offices(id),
	constraint fk_leader_id
    foreign key (leader_id) references employees(id)
);

create table games(
	id int primary key auto_increment,
    `name` varchar(50) not null unique,
	`description` text, 
    rating float default 5.5 not null, 
    budget decimal(10,2) not null, 
    `release_date` date,
    team_id int,
	constraint fk_team_id
    foreign key (team_id) references teams(id)
);

create table games_categories(
	game_id int  not null,
    category_id int not null,
	constraint pk_game_id primary key(game_id , category_id),
	constraint fk_game_id
    foreign key (game_id) references games(id),
	constraint fk_category_id
    foreign key (category_id) references categories(id)
);

#2
insert into games (`name`, rating, budget, team_id)
select
    lower(substring(reverse(`name`), 1,char_length(`name`)-1)),
    id as rating,
    leader_id * 1000 as budget,
    id as team_id
from teams
where id between 1 and 9 ;

#3
UPDATE employees
INNER JOIN teams ON employees.id = teams.leader_id
SET employees.salary = employees.salary + 1000
WHERE employees.age < 40
    AND employees.salary < 5000
    AND employees.job_title = 'Team Leader';

# 4
delete from games g
WHERE release_date IS NULL and id not in (select game_id from games_categories);

#5
select first_name, last_name, age, salary, happiness_level from employees  
order by salary asc ,id asc;

#6
select t.`name` as team_name , a.`name`  as address_name , length(a.`name`) as count_of_characters
from teams t
join offices o
on t.office_id = o.id
join addresses a
on a.id = o.address_id
where o.website is not null
order by t.`name`, a.`name`;

#7
select 
	c.`name` , 
    count(c.`name`) as games_count , 
    round(avg(g.budget),2) as avg_budget , 
    max(g.rating) as max_rating 
from categories c
join games_categories gc
on gc.category_id = c.id
join games g
on g.id = gc.game_id
group by c.`name` 
having  max_rating >= 9.5 
order by games_count desc , c.`name`;

#8
SELECT 
    g.`name` AS `name`,
    g.release_date AS release_date,
    CONCAT(SUBSTRING(g.description, 1, 10), '...') AS summary,
    CASE 
        WHEN MONTH(g.release_date) IN (1, 2, 3) THEN 'Q1'
        WHEN MONTH(g.release_date) IN (4, 5, 6) THEN 'Q2'
        WHEN MONTH(g.release_date) IN (7, 8, 9) THEN 'Q3'
        WHEN MONTH(g.release_date) IN (10, 11, 12) THEN 'Q4'
    END AS `quarter`,
    t.`name` AS team_name
FROM games g
JOIN teams t 
ON g.team_id = t.id
WHERE 
    YEAR(g.release_date) = 2022
    AND MONTH(g.release_date) % 2 = 0
    AND g.`name` LIKE '%2'
    AND g.`name` NOT LIKE '%3'
ORDER BY 
    `quarter`;
    
#9
select g.`name` , 
	case 
		when g.budget < 50000 then 'Normal budget'
        when g.budget >= 50000 then 'Insufficient budget'
	end as budget_level ,
    t.`name` as team_name,
    a.`name` as address_name 
from games g
join teams t
on t.id = g.team_id
join offices o
on t.office_id = o.id
join addresses a
on o.address_id =a.id
where g.release_date is null  AND NOT EXISTS (
        SELECT 1
        FROM games_categories gc
        WHERE gc.game_id = g.id
    )
order by g.`name`;

#10
delimiter $$
create function udf_game_info_by_name (game_name VARCHAR (20)) 
returns text
deterministic 
begin
    DECLARE game_info text;
    SELECT CONCAT('The ', g.`name` , ' is developed by a ', t.`name` , ' in an office with an address ', a.`name` )
    INTO game_info
    FROM games g
    JOIN teams t ON g.team_id = t.id
    JOIN offices o ON t.office_id = o.id
    JOIN addresses a ON o.address_id = a.id
    WHERE g.`name` = game_name;
    RETURN game_info;
end$$

#11
DELIMITER $$
create procedure udp_update_budget(in min_game_rating float)
begin
    update games 
    set budget = budget + 100000,
        release_date = DATE_ADD(release_date, interval 1 year)
    where  release_date IS NOT NULL
        AND rating > min_game_rating;

END$$


