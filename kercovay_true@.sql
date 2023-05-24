
drop database `cars2`;
create  database `cars2`;
use `cars2`;
DROP TABLE IF EXISTS `profiles`;
-- таблица "профили" индификация пользователя может выполнятся, как по id, так и по user_name
-- содержит стандартный набор общей информации 
CREATE TABLE `profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50)  DEFAULT NULL,
  `password_hash` varchar(50)  DEFAULT NULL,
  `phone` bigint DEFAULT NULL,
  `created _at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `users_phone_idx` (`phone`)
);

insert profiles (id, user_name, password_hash, phone, `created _at`, hometown)
values
(2,'Denis', '13421fd2ef23', '890266737372', '2000-06-28 02:09:20', 'city'),
(3,'Oleg', '134212121fd2ef23', '890261717372', '2000-06-28 02:09:20', 'irk'),
(4,'Ivan', '13431221f32d2ef23', '890226577372', '2000-06-28 02:09:20', 'ang'),
(5,'Makar', '1342fds1fd2ef23', '89026676372', '2000-06-28 02:09:20', 'brat'),
(6,'Olga', '13421dsfg34fd2ef23', '890263547372', '2000-06-28 02:09:20', 'ach'),
(7,'Kate', '13421fdsfdsd2ef23', '8901667347372', '2000-06-28 02:09:20', 'kras'),
(8,'Dina', '13421fdsfgerwd2ef23', '8902322677372', '2000-06-28 02:09:20', 'mag'),
(9,'Mahsa', '13421fdewrwer2ef23', '890366727372', '2000-06-28 02:09:20', 'mosc'),
(10,'Glasha', '13421fddsfgsdf2ef23', '890466177372', '2000-06-28 02:09:20', 'spb'),
(11,'igor', '13421fd2eewrwertf23', '890566773762', '2000-06-28 02:09:20', 'vrag'),
(12,'Zak', '13421fd2ewweewef23', '890666773772', '2000-06-28 02:09:20', 'ukr'),
(13,'Bak', '13421fdrewt22ef23', '890766773792', '2000-06-28 02:09:20', 'mag');

#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;
-- таблица сообщение между пользователями
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text  DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `messages_from_user_id` (`from_user_id`),
  KEY `messages_to_user_id` (`to_user_id`),
  FOREIGN KEY (`from_user_id`) REFERENCES `profiles` (`id`)on delete cascade on update cascade,
  FOREIGN KEY (`to_user_id`) REFERENCES `profiles` (`id`) on delete cascade on update cascade
);


INSERT INTO `messages`
(`from_user_id`, `to_user_id`, `body`, `created_at`)
values
(2, 2, 'dasvdvas', CURRENT_TIMESTAMP),
(2, 10, 'asdvasdvasdvas', CURRENT_TIMESTAMP),
(3, 9, 'dvasdvasdvasdva', CURRENT_TIMESTAMP),
(4, 4, 'asdsfadqwe', CURRENT_TIMESTAMP),
(2, 5, 'awdvqwvwerbsc', CURRENT_TIMESTAMP),
(3, 6, 'dvscxvasdfqweva', CURRENT_TIMESTAMP),
(10, 2, 'asdgasdgasdcasdc', CURRENT_TIMESTAMP),
(2, 7, 'asdfasfdsadfdg', CURRENT_TIMESTAMP),
(4, 7, 'rwtwerwerfwer', CURRENT_TIMESTAMP),
(4, 8, 'evfsdcvxzcqwdfqw', CURRENT_TIMESTAMP),
(5, 2, 'wfsdvwefvsfdvsdfv', CURRENT_TIMESTAMP);



DROP TABLE IF EXISTS `brand`;
-- таблица с именами брендов авто (в одной не мог все это представить)
CREATE TABLE `brand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_brand` varchar(100) unique  DEFAULT NULL,
  PRIMARY KEY (`id`));
 
 INSERT INTO `brand` (`id`, `name_brand`) values
 ('1', ' gaz'),
('2', ' chevrolet'),
('3', 'toyota'),
('4', ' vaz'),
('5', ' bmw'),
('6', ' mazda'),
('7', ' mercedes'),
('8', ' honda'),
('9', 'lamborgini'),
('10', ' uaz'),
('11', ' subaru');
 
 
 DROP TABLE IF EXISTS `model`;
-- хранится модель авто ОПРЕДЕЛЕННОГО бренда, имя и свзяь с id брендом
CREATE TABLE `model` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_model` varchar(100) unique  DEFAULT null ,
  `brand_id` bigint(20) unsigned NOT NULL,
   PRIMARY KEY (`id`),
 foreign key (`brand_id`) references `brand` (`id`) on delete cascade on update cascade 
);
INSERT INTO `model` (`id`, `name_model`, `brand_id` ) VALUES 
('1', ' cx-5', '6'),
('2', ' legacy', '11'),
('3', ' impreza', '11'),
 ('4', ' tribeca', '11'),
 ('5', 'camry', '3'),
('6', ' r2', '11'),
('7', 'corona', '3'),
('8', ' fit', '8'),
 ('9', 'alion', '3'),
('10', ' premio', '3'),
('11', ' sportage', '7'),
('12', 'rav4', '3'),
('13', 'amg', '7'),
('14', ' civic', '8'),
('15', ' cx-7', '6'),
('16', ' cr-v', '8'),
('17', ' halux', '3'),
('18', ' impreza wrx', '11'),
('19', ' 2107', '4'),
('20', ' 3', '6'),
('21', ' brz', '11'),
('22', ' m3', '5'),
('23', ' outback', '11'),
('24', 'crown', '3'),
('25', ' cx-1', '6'),
('26', ' land cruizer', '3'),
('27', 'alex', '3'),
('28', ' 5', '6'),
('29', 'sambara', '11'),
('30', ' forester', '11');


 DROP TABLE IF EXISTS `complictation`;
-- комплектация определеной модели авто связаная с конкретной моделью
-- здесь выбираются основные параметры для авто, которое будет выставленно на продажу 
CREATE TABLE `complictation`(
  `id` serial primary key,
  `model_id` bigint(20) unsigned NOT NULL,
  `date_release` datetime DEFAULT NULL,
  `horse_power` int(30) DEFAULT NULL,
  `transmission` varchar(100)  DEFAULT NULL,
  `color` varchar(100)  DEFAULT NULL,
  `type_of_fuel` varchar(100)  DEFAULT NULL,
  foreign key (`model_id`) references `model` (`id`) on delete cascade on update cascade);

 INSERT INTO `complictation` (`id`, `model_id`, `date_release`, `horse_power`, `transmission`, `color`, `type_of_fuel`) values
('1', '2', '1985-02-01 00:00:00', 82, 'AS', 'green', 'GAS'),
('2', '3',  '1993-02-12 00:00:00', 85, ' MS', 'aqua', 'GAS'),
('3', '3', '2000-01-21 00:00:00', 84, ' MS', 'navy', 'GAS'),
('4', '2', '1984-05-31 00:00:00', 151, 'AS', 'navy', ' Electro'),
('5', '1', '2000-09-05 00:00:00', 181, ' MS', 'silver', 'GAS'),
('6', '1', '1996-10-09 00:00:00', 92, 'AS', 'lime', ' Electro'),
('7', '24', '1981-06-15 00:00:00', 121, 'AS', 'fuchsia', 'GAS'),
('8', '5', '1985-12-13 00:00:00', 141, ' MS', 'black', 'GAS'),
('9', '6', '1971-06-04 00:00:00', 120, 'AS', 'green', 'GAS'),
('10', '6', '1982-03-07 00:00:00', 75, ' MS', 'navy', ' Electro'),
('11', '10', '1977-11-17 00:00:00', 71, ' MS', 'fuchsia', ' Electro'),
('12', '20', '2007-11-07 00:00:00', 132, ' MS', 'fuchsia', ' Electro'),
('13', '8', '1981-07-27 00:00:00', 183, 'AS', 'lime', ' Electro'),
('14', '12', '2018-04-14 00:00:00', 194, 'AS', 'blue', ' Dizel'),
('15', '20', '1996-04-24 00:00:00', 115, ' MS', 'blue', ' Dizel'),
('16', '30', '1981-12-14 00:00:00', 116, ' MS', 'gray', ' Dizel'),
('17', '13', '2007-12-27 00:00:00', 169, 'AS', 'olive', ' Electro'),
('18', '13', '2018-11-05 00:00:00', 64, ' MS', 'olive', ' Dizel'),
('19', '12', '1970-02-05 00:00:00', 171, 'AS', 'fuchsia', ' Dizel'),
('20', '11', '2009-02-24 00:00:00', 196, ' MS', 'purple', ' Dizel'),
('21', '1', '1987-09-16 00:00:00', 86, ' MS', 'black', ' Dizel'),
('22', '16', '2004-03-24 00:00:00', 67, 'AS', 'olive', 'GAS'),
('23', '8', '1986-12-15 00:00:00', 132, 'AS', 'yellow', ' Dizel'),
('24', '25', '2015-06-26 00:00:00', 124, 'AS', 'olive', ' Electro'),
('25', '22', '1997-08-01 00:00:00', 112, ' MS', 'maroon', 'GAS'),
('26', '22', '1994-03-01 00:00:00', 118, ' MS', 'blue', 'GAS'),
('27', '9', '1998-05-25 00:00:00', 116, ' MS', 'purple', 'GAS'),
('28', '21', '2011-09-26 00:00:00', 165, 'AS', 'purple', 'GAS'),
('29', '19', '2005-09-14 00:00:00', 191, 'AS', 'green', ' Electro'),
('30', '18', '1996-10-25 00:00:00', 69, ' MS', 'black', ' Dizel');


DROP TABLE IF EXISTS `announcement`;
-- главная таблица, из которой в последующем формруется страница о продаже авто
-- эта таблица связанна почти со всеми другим
CREATE TABLE `announcement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` bigint(20) unsigned NOT NULL,
  `brand_id` bigint(20) unsigned NOT NULL,
  `price` decimal unsigned NOT NULL,
  `photo_of_cars` longtext CHARACTER SET utf8mb4  DEFAULT NULL CHECK (json_valid(`photo_of_cars`)),
  `indentification_number` varchar(100)  DEFAULT NULL,
  `created _at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `town` varchar(100)  DEFAULT NULL,
  `description` text  DEFAULT NULL,
  `views` bigint(10) unsigned DEFAULT NULL,
   UNIQUE KEY `indentification_number` (`indentification_number`),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE ON UPDATE cascade,
  FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE cascade,
  FOREIGN KEY (`views`) REFERENCES `profiles` (`id`) ON DELETE set null ON UPDATE cascade);
 
 insert announcement (id, profiles_id, brand_id, price, photo_of_cars, indentification_number, `created _at`, town, description, views)
values
(12, 2, 1, 1000000, 1, '13421231fd2ef23', '2000-10-28 02:09:20', 'irkutsk', null, null),
(2, 2, 2, 350000, 2, '13421fd2ef23', '2000-05-28 02:09:20', 'city', null, null),
(3, 3, 3, 285000, 3, '134212121fd2ef23', '2000-05-28 02:09:20', 'irk', null, null),
(4, 4, 4, 10000, 1,  '13431221f32d2ef23', '2000-05-28 02:09:20', 'ang', null, null),
(5, 5, 5,  280000, 2, '1342fds1fd2ef23', '2000-10-28 02:09:20', 'brat', null, null),
(6, 6, 6, 850000, 6, '13421dsfg34fd2ef23', '2000-02-28 02:09:20', 'ach', null, null),
(7, 7, 7, 300000, 8, '13421fdsfdsd2ef23', '2000-02-28 02:09:20', 'kras', null, null),
(8, 8, 8, 555000, 9, '13421fdsfgerwd2ef23', '2000-02-28 02:09:20', 'mag', null, null),
(9, 9, 9, 975000, 10, '13421fdewrwer2ef23', '2000-01-28 02:09:20', 'mosc', null, null),
(10, 10, 10, 50000000, 8, '13421fddsfgsdf2ef23', '2000-01-28 02:09:20', 'spb', null, null),
(11, 11, 11, 36990000, 6, '13421fd2eewrwertf23', '2000-01-28 02:09:20', 'vrag', null, null);


DROP TABLE IF EXISTS `status`;
-- таблица показывает оплаченно ли объявление, чтобы в полседущем его можно было выставить на главную страницу
CREATE TABLE `status` (
  `id` bigint(20) unsigned NOT NULL,
  `payment` enum('YES','NOT')  DEFAULT NULL,
  `status_announcement` enum('high','middle','low')  DEFAULT NULL,
  PRIMARY KEY (`id`),
  foreign key (`id`) references `announcement` (id) on delete cascade on update cascade
);

INSERT INTO `status` (`id`, `payment`, `status_announcement`) VALUES 
('2', 'NOT', 'low'),
 ('3', 'YES', 'high'),
('4', 'YES', 'middle'),
('5', 'NOT', 'low'),
('6', 'YES', 'high'),
('7', 'YES', 'high'),
('8', 'YES', 'middle'),
('9', 'YES', 'high'),
('10', 'NOT', 'low'),
('11', 'YES', 'middle'),
('12', 'NOT', 'high');

DROP TABLE IF EXISTS `history_car`;
-- в этой таблице хранится история авто, если оно когда то было выставленно на продажу
-- чтобы в последующем можно было продать человеку, который хочет преобрести авто
-- свзян по уникальному индентификационному номеру авто
CREATE TABLE `history_car` (
  `id` SERIAL ,
  `indentification_number_id` varchar(100)  DEFAULT NULL,
  `accident` enum('YES','NOT')  DEFAULT NULL,
  `how_many_owners` bigint(20) NOT NULL,
  `photo_of_car` longtext CHARACTER SET utf8mb4  DEFAULT NULL CHECK (json_valid(`photo_of_car`)),
  `past_of_announcement` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `indentification_number_id` (`indentification_number_id`),
  foreign key (`indentification_number_id`) references `announcement` (`indentification_number`)ON DELETE SET NULL ON UPDATE cascade
);

INSERT INTO `history_car`
(`indentification_number_id`, `accident`, `how_many_owners`, `photo_of_car`, `past_of_announcement`)
values
('13421231fd2ef23', 'YES', 1, NULL, 0),
('134212121fd2ef23', 'NOT', 2, NULL, 0),
('1342fds1fd2ef23', 'YES', 7, NULL, 0),
('13421fdsfgerwd2ef23', 'NOT', 4, NULL, 0),
('13421fdewrwer2ef23', 'NOT', 1, NULL, 0),
('13421fddsfgsdf2ef23', 'YES', 8, NULL, 0),
('13421fd2eewrwertf23', 'NOT', 2, NULL, 0);
