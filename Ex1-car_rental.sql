create database `ex1-car_rental`;
use `ex1-car_rental`;

#12
create table categories (
    id int not null auto_increment primary key,
    category  varchar(50) not null,
    daily_rate decimal(10, 2) not null,
    weekly_rate decimal(10, 2) not null,
    monthly_rate decimal(10, 2) not null,
    weekend_rate decimal(10, 2) not null
);

insert into categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
values
    ('Compact', 50.00, 300.00, 1000.00, 60.00),
    ('Sedan', 60.00, 350.00, 1200.00, 70.00),
    ('SUV', 80.00, 450.00, 1500.00, 90.00);

create table cars (
    id int not null auto_increment primary key,
    plate_number varchar(15) not null,
    make varchar(50) not null,
    model varchar(50) not null,
    car_year int not null,
    category_id int not null,
    doors int not null,
    picture varchar(255),
    car_condition varchar(50) not null,
    available boolean not null
);

insert into  cars (plate_number, make, model, car_year, category_id, doors, car_condition, available)
values
    ('ABC123', 'Toyota', 'Corolla', 2022, 1, 4, 'Good', TRUE),
    ('XYZ789', 'Honda', 'Civic', 2021, 2, 4, 'Excellent', TRUE),
    ('DEF456', 'Ford', 'Escape', 2020, 3, 5, 'Fair', FALSE);

create table employees (
    id int not null auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    title varchar(50) not null,
    notes text
);

insert into  employees (first_name, last_name, title, notes)
values
    ('John', 'Doe', 'Manager', 'Employee since 2018'),
    ('Jane', 'Smith', 'Clerk', 'Part-time employee'),
    ('David', 'Johnson', 'Mechanic', NULL);

create table customers (
    id int not null auto_increment primary key,
    driver_licence_number varchar(20) not null,
    full_name varchar(100) not null,
    address varchar(50),
    city varchar(50),
    zip_code varchar(10),
    notes text
);

insert into  customers (driver_licence_number, full_name, address, city, zip_code, notes)
values
    ('DL123456', 'Alice Johnson', '123 Main St', 'Anytown', '12345', 'VIP customer'),
    ('DL789012', 'Bob Smith', '456 Elm St', 'Another City', '54321', null),
    ('DL456789', 'Charlie Brown', '789 Oak St', 'Cityville', '67890', 'Frequent renter');


create table rental_orders (
    id int not null auto_increment primary key,
    employee_id int not null,
    customer_id int not null,
    car_id int not null,
    car_condition varchar(50) not null	,
    tank_level decimal(4, 2) not null,
    kilometrage_start int not null,
    kilometrage_end int not null,
    total_kilometrage int not null,
    start_date date not null,
    end_date date not null,
    total_days int not null,
    rate_applied decimal(10, 2) not null,
    tax_rate decimal(4, 2) not null,
    order_status varchar(20) not null,
    notes text
);

insert into  rental_orders (employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
values
    (1, 1, 1, 'Excellent', 95.5, 10000, 10200, 200, '2023-10-15', '2023-10-18', 3, 60.00, 0.08, 'Completed', 'Customer was satisfied'),
    (2, 2, 2, 'Good', 75.0, 7500, 7800, 300, '2023-10-16', '2023-10-19', 3, 70.00, 0.08, 'In Progress', 'Customer extended rental'),
    (1, 3, 3, 'Fair', 50.0, 3000, 3200, 200, '2023-10-17', '2023-10-20', 3, 80.00, 0.08, 'Completed', 'Regular customer');
