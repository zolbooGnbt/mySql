#11
create database `ex1-Movies`;
use `ex1-Movies`;
create table directors (
id int auto_increment primary key,
director_name varchar(50) not null,
notes varchar(100));

create table genres (
id int auto_increment primary key,
genre_name varchar(50) not null,
notes varchar(100));

create table categories (
id int auto_increment primary key,
category_name varchar(50) not null,
notes varchar(100));

create table movies (
id int auto_increment primary key,
title varchar(50) not null,
copyright_year date, 
length time,
genre_id int, 
category_id int, 
rating int, 
notes varchar(100));

insert into directors (director_name, notes)
values
    ('Director 1', 'Note 1'),
    ('Director 2', 'Note 2'),
    ('Director 3', 'Note 3'),
    ('Director 4', 'Note 4'),
    ('Director 5', 'Note 5');
    
insert into genres (genre_name, notes)
values
    ('Genre 1', 'Note 1'),
    ('Genre 2', 'Note 2'),
    ('Genre 3', 'Note 3'),
    ('Genre 4', 'Note 4'),
    ('Genre 5', 'Note 5');

insert into categories (category_name, notes)
values
    ('Category 1', 'Note 1'),
    ('Category 2', 'Note 2'),
    ('Category 3', 'Note 3'),
    ('Category 4', 'Note 4'),
    ('Category 5', 'Note 5');

insert into movies (title, copyright_year, length, genre_id, category_id, rating, notes)
values
    ('Movie 1', '2020-01-01', '01:45:00', 1, 1, 4, 'Note 1'),
    ('Movie 2', '2019-02-15', '02:10:00', 2, 2, 3, 'Note 2'),
    ('Movie 3', '2021-11-30', '01:30:00', 3, 3, 5, 'Note 3'),
    ('Movie 4', '2018-06-20', '02:20:00', 4, 4, 4, 'Note 4'),
    ('Movie 5', '2017-12-10', '02:00:00', 5, 5, 2, 'Note 5');