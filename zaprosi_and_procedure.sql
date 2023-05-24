use cars2;

-- берет компелктацию у конкретной  модели и марки
select c.id, name_model, name_brand from announcement a 
join model m on a.id = m.id
join brand b on a.id = b.id
join complictation c on a.id = c.id 
group by name_model ; 

-- имя модели, которая проадется за цену меньше 1млн
select name_model from model m 
where m.id = (select price from announcement a
	where price < 1000000 and m.id = a.id);

-- ищет цену  и модель  только с автоматом 
select price, name_model from announcement a 
join complictation c on a.id = c.id 
join model m on m.id = a.id
where transmission = 'AS' 

-- в продаже модели, у которых есть статус оплаты.
select (select name_model from model m where m.id = a.id) from announcement a 
where (select id from status s
	where payment = 'YES' and s.id = a.id)

	-- выводить id профиля у которго есть объявление 
select p.id from profiles p 
join announcement a on a.id = p.id 
join status s on s.id = a.id
where payment = 'YES'


use cars2;

DROP PROCEDURE IF EXISTS sp_announcement_high;



-- select ... //
DROP PROCEDURE IF EXISTS sp_announcement_high;
delimiter //
CREATE PROCEDURE `sp_announcement_high`(in profiles_id BIGINT)
begin
	-- показывает объявления с повышеным статусом
	select a.id, a.photo_of_cars from announcement a
	join status s on a.id = s.id 
	where status_announcement = 'high' and payment = 'YES'
 	union 
 	-- город продажи равен городу юзера 
 	select a.id, a.photo_of_cars from announcement a
 	join profiles p on a.profiles_id = p.id 
 	where a.town = p.hometown 
 	order by rand()
 	limit 10; 
end//

delimiter ;

call sp_announcement_high(1 )



DROP PROCEDURE IF EXISTS sp_profiles_add;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cars2`.`sp_profiles_add`(
user_name varchar(50), password_hash varchar(50), email varchar(100), 
phone varchar(50), hometown varchar(50),
OUT  tran_result varchar(100))
BEGIN
	
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 


	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = concat('УПС. Ошибка: ', code, ' Текст ошибки: ', error_string);
	END;

	START TRANSACTION;
	 INSERT INTO profiles (user_name, password_hash, email, phone, hometown)
	 VALUES (user_name, password_hash, email, phone, hometown);
	
	
	
	INSERT INTO profiles (profile_id, hometown)
	VALUES (last_insert_id(), hometown);
	
	if `_rollback` then
		rollback;
	else
		set tran_result = 'O K';
		commit;
	end if;
end$$
delimiter ;


