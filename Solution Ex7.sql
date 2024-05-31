USE `ex7-soft_uni`;

#1
delimiter $$
create procedure usp_get_employees_salary_above_35000 ()
begin
	select first_name , last_name from employees
    where salary > 35000
    order by first_name asc, last_name asc;
end$$;

#2
delimiter $$
create procedure usp_get_employees_salary_above (in employee_salary decimal(19,4))
begin
	select first_name , last_name
    from employees as e
    where e.salary >= employee_salary
    order by e.first_name , e.last_name ;
end$$;
    
#3
delimiter $$ 
create procedure usp_get_towns_starting_with (`town_name_start_with` varchar(50))
begin
	select t.`name` from towns as t
    where t.`name` like concat(`town_name_start_with`,'%')
    order by t.`name`;
end$$


#4
delimiter $$
create procedure usp_get_employees_from_town (`town_name` varchar(50))
begin
	select e.first_name , e.last_name from employees as e
    join addresses as a on a.address_id = e.address_id
    join towns as t on t.town_id = a.town_id
    where t.`name` = town_name
    order by first_name , last_name;
end$$;

#5
delimiter $$
create function ufn_get_salary_level (salary decimal(19,4))
returns varchar(50)
deterministic
begin
	declare salary_Level varchar(10);
    if salary < 30000 then 
    set salary_Level ='Low';
	elseif salary <= 50000 then
    set salary_Level = "Average";
    else 
    set salary_Level = 'High';
	end if;
    return salary_Level;
end$$

#6
delimiter $$
create procedure usp_get_employees_by_salary_level (level_of_salary varchar(15))
begin
	select e.first_name , e.last_name 
    from (
		select em.first_name , em.last_name , ufn_get_salary_level(em.salary) as salary_Level 
		from employees as em
        order by first_name desc , last_name desc) 
	as e
	where e.salary_Level = level_of_salary;
end$$

#7
delimiter $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
BEGIN
    DECLARE set_length INT;
    DECLARE word_length INT;
    DECLARE i INT;
    DECLARE letter_count INT;
    
    SET set_length = CHAR_LENGTH(set_of_letters);
    SET word_length = CHAR_LENGTH(word);
    SET i = 1;
    SET letter_count = 0;

    WHILE i <= word_length DO
        IF LOCATE(SUBSTRING(word, i, 1), set_of_letters) > 0 THEN
            SET letter_count = letter_count + 1;
        END IF;
        SET i = i + 1;
    END WHILE;

    IF letter_count = word_length THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
end$$

#8
delimiter $$
create procedure usp_get_holders_full_name ()
begin
	select concat(a.first_name ,' ',a.last_name) as full_name
    from account_holders as a
    order by full_name ;
end$$

#9
delimiter $$
create procedure usp_get_holders_with_balance_higher_than (in num decimal(19,4))
begin
	select h.first_name , h.last_name from account_holders as h
    join accounts as a 
    on h.id = a.account_holder_id
    group by ah.id
    having sum(a.balance) > num;
end$$

call usp_get_holders_with_balance_higher_than (7000)

#10
delimiter $$
create function ufn_calculate_future_value (initial_sum decimal(19,4),yearly_interest_rate double,number_of_years int)
returns decimal(19,4)
deterministic
begin
	return initial_sum * pow(1+yearly_interest_rate, number_of_years);
end$$

#11
delimiter $$  
create procedure usp_calculate_future_value_for_account (account_id int, iterast_rate float)
begin
	select a.id as account_id , h.first_name , h.last_name ,a.balance as current_balance,
     ufn_calculate_future_value(a.balance, iterast_rate , 5) as balance_in_5_years
     from account_holders as h
     join accounts as a
     on h.id = a.account_holder_id
     where a.id = account_id;
end$$

#12
delimiter $$  
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(18,4))
BEGIN
    DECLARE balance DECIMAL(18,4);
    DECLARE new_balance DECIMAL(18,4);
    
    IF money_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid money amount. Must be positive.';
    END IF;
    
    START TRANSACTION;
    
    -- Get current balance
    SELECT balance INTO balance FROM accounts WHERE id = account_id;
    
    -- Update balance with deposited amount
    SET new_balance = balance + money_amount;
    UPDATE accounts SET balance = new_balance WHERE id = account_id;
    
    COMMIT;
END