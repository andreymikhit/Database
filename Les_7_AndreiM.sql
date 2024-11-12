/*
Lesson-7 / Vers.1 (26.08.2020)
========
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/



-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

USE shop;

SELECT id, name
FROM users; 
	
SELECT *
FROM orders;
-- таблица заказов пустая, необходимо её заполнить

INSERT orders(user_id) VALUES
	('1'),
	('5'),
	('2'),
	('3'),
	('4'),
	('3');

SELECT
	u.id AS user_id, u.name,
	o.id AS order_id
FROM
	users AS us
RIGHT JOIN
	orders AS ord
ON u.id = o.user_id;


-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
	p.id, p.name, p.price,
	c.id AS catalogs_id,
	c.name AS catalog
FROM
	products AS prod
JOIN
	catalogs AS cat
ON p.catalog_id = c.id;



-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.


DROP DATABASE IF EXISTS aeroport;
CREATE DATABASE aeroport;
USE aeroport;


CREATE TABLE IF NOT EXISTS cities (
  label VARCHAR(255),
  name VARCHAR(255),
  INDEX label_idx(label)   -- делаешь названия на английском индексами поэтому у тебя и не делались FOREIGN KEY
);

CREATE TABLE IF NOT EXISTS flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255) NOT NULL,
  `to` VARCHAR(255) NOT NULL
);

ALTER TABLE flights
ADD CONSTRAINT fk_from_label
FOREIGN KEY(`from`)
REFERENCES cities(label);


ALTER TABLE flights
ADD CONSTRAINT fk_to_label
FOREIGN KEY(`to`)
REFERENCES cities(label);


INSERT cities VALUES 			
	('Moscow', 'Москва'),		
	('London', 'Лондон'),
	('Minsk', 'Minsk'),
	('Berlin', 'Берлин'),
	('Донецк', 'Donetsk'),
	('Simferopol', 'Симферополь'),
	('Adler', 'Адлер'),
	('Kaliningrad', 'Калининград'),
	('Кострома', 'Кострома'),
	('Vladivostok', 'Владивосток'),
	('Frankfurt Main', 'Франкфурт на Майне');


INSERT flights VALUES
	(NULL, 'Moscow', 'London'),
	(NULL, 'Minsk', 'Saint Petersburg'),
	(NULL, 'Kaliningrad', 'Minsk'),
	(NULL, 'Adler', 'Moscow'),
	(NULL, 'Kaliningrad', 'Berlin'),
	(NULL, 'Кострома', 'Симферополь');


SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;
	

-- с JOIN

SELECT `from`.id, `from`.name 'from', `to`.name 'to'
FROM 
(
	SELECT f2.id id, c2.name name
	FROM flights f2 
	JOIN
	cities c2 
	ON `from` = label 
) AS `from`,
(
	SELECT f2.id id, c2.name name 
	FROM flights f2 
	JOIN
	cities c2 
	ON `to` = label 
) AS `to`
WHERE `to`.id = `from`.id
ORDER BY `from`.id
;