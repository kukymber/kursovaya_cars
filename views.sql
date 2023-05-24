-- показывет данные для страницы объявления авто
create or replace
algorithm = UNDEFINED view `cars2`.`car_annoucement` as
select
    `a`.`id` as `id`,
    `a`.`price` as `price`,
    `b`.`name_brand` as `name_brand`,
    `m`.`name_model` as `name_model`,
    `c`.`date_release` as `date_release`,
    `c`.`horse_power` as `horse_power`,
    `c`.`transmission` as `transmission`,
    `c`.`color` as `color`,
    `c`.`type_of_fuel` as `type_of_fuel`,
    `a`.`description` as `description`,
    `a`.`town` as `town`
from
    (((`cars2`.`announcement` `a`
join `cars2`.`brand` `b` on
    ((`b`.`id` = `a`.`id`)))
join `cars2`.`model` `m` on
    ((`m`.`id` = `a`.`id`)))
join `cars2`.`complictation` `c` on
    ((`c`.`id` = `a`.`id`)))

    
    
    
-- показывает есть ли история у конкретного авто с конткретным вин(можно продать историю)    
create or replace
algorithm = UNDEFINED view `cars2`.`have_history` as
select
    `a`.`id` as `number of announcement`,
    `b`.`name_brand` as `brand`,
    `m`.`name_model` as `model`,
    `hc`.`indentification_number_id` as `indentification number`
from
    (((`cars2`.`announcement` `a`
join `cars2`.`brand` `b` on
    ((`b`.`id` = `a`.`id`)))
join `cars2`.`model` `m` on
    ((`m`.`id` = `a`.`id`)))
join `cars2`.`history_car` `hc` on
    ((`hc`.`indentification_number_id` = `a`.`indentification_number`)))
where
    (`a`.`indentification_number` = `hc`.`indentification_number_id`)