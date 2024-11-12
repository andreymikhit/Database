/*
Lesson-9 / Vers.1 (02.09.2020)
========
I Практическое задание по теме “Транзакции, переменные, представления”
********************************************************************
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
1. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

II Практическое задание по теме “Администрирование MySQL”
******************************************************
(эта тема изучается по вашему желанию)
1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

III Практическое задание по теме “Хранимые процедуры и функции, триггеры"
*********************************************************************
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

0  1  2  3  4  5  6   7   8   9  10
0  1  1  2  3  5  8  13  21  34  55
*/



-- I.1
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

START TRANSACTION;
INSERT sample.users SELECT * FROM shop.users WHERE id=1;
DELETE FROM shop.users WHERE id=1;
COMMIT;

SELECT * FROM sample.users;
SELECT * FROM shop.users;


-- I.2
USE shop;
CREATE OR REPLACE VIEW positions AS SELECT p.name name, c.name catalogs FROM products p JOIN catalogs c ON p.catalog_id = c.id;
SELECT * FROM POSITIONS;


-- I.3
USE shop;
DROP TABLE IF EXISTS data_table;
CREATE TABLE data_table (
	created_at DATE
);

INSERT INTO data_table VALUES
	('2016-08-04'),
	('2018-08-01'),
	('2018-09-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-06-01'),
	('2018-08-17'),
	('2019-08-17'),
	('2019-08-17'),
	('2019-08-17'),
	('2020-08-17'),
	('2020-08-17');

SELECT month_date, IF(idx=1, 1, 0) idx
FROM 
 (SELECT month_date from 
 (select adddate('1990-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) month_date from
 (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
 (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
 (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
 (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
 (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
 where month_date between '2018-08-01' and '2018-08-31') AS  aug_date 
LEFT JOIN 
 (SELECT IF (data_table.created_at BETWEEN '2018-08-01' and '2018-08-31', 1, 0) AS idx, data_table.created_at FROM data_table) AS index_ 
ON month_date = index_.created_at; 


-- I.4
SELECT * FROM data_table ORDER BY created_at DESC LIMIT 5;

START TRANSACTION;
CREATE TEMPORARY TABLE temp (
	created_at DATE
);
INSERT INTO temp
SELECT created_at FROM data_table ORDER BY created_at DESC LIMIT 5;
TRUNCATE TABLE data_table;
INSERT INTO data_table
SELECT * FROM temp;
drop TABLE IF EXISTS  temp;
COMMIT;

sELECT * FROM data_table ORDER BY created_at DESC;


-- II.1
CREATE USER shop_all;
CREATE USER shop_read;
GRANT USAGE ON shop.* TO shop_all;
GRANT SELECT ON  shop.* TO shop_read;
SHOW grants;


-- II.2
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	`password` VARCHAR(255)
);

INSERT INTO accounts (name, `password`) VALUES
  ('Геннадий', 'abcD1'),
  ('Наталья', 'bcdF2'),
  ('Александр', 'cdfG3'),
  ('Сергей', 'dfgH4'),
  ('Иван', 'fghI5');

CREATE OR REPLACE VIEW username AS SELECT id, name FROM accounts;
SELECT * FROM username;
CREATE USER user_read;
GRANT SELECT ON  shop.username TO user_read;


-- III.1
DROP FUNCTION IF EXISTS hello;
delimiter //
CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC
BEGIN
	DECLARE HOUR_NOW int;
	SET HOUR_NOW = hour(NOW());
	CASE 
		WHEN HOUR_NOW BETWEEN 0 AND 5 THEN RETURN 'Доброй ночи';
		WHEN HOUR_NOW BETWEEN 5 AND 11 THEN RETURN 'Доброе утро';
		WHEN HOUR_NOW BETWEEN 11 AND 17 THEN RETURN 'Добрый день';
		else RETURN 'Добрый вечер';
	END CASE;
END//

SELECT hello() LIMIT 1;


-- III.2
CREATE TRIGGER CHECK_name BEFORE UPDATE ON products 
FOR EACH ROW 
BEGIN 
	SET NEW.name = COALESCE(NEW.name, OLD.name, OLD.name);
END//

CREATE TRIGGER CHECK_description BEFORE UPDATE ON products 
FOR EACH ROW 
BEGIN 
	SET NEW.description = COALESCE(NEW.description, OLD.description, OLD.description);
END//


-- III.3
DROP FUNCTION IF EXISTS fibonachi;
delimiter //
CREATE FUNCTION fibonachi(NUM INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE Counter INT DEFAULT 3;
    DECLARE One INT DEFAULT 1;
    DECLARE Two INT DEFAULT 1;
	IF NUM > 2 THEN
 	 WHILE NUM >= Counter DO
	  SET Two = One + Two;
      SET One = Two - One;
	  SET Counter = Counter + 1;
	 END WHILE;
	END	IF;
	RETURN Two;
END//;
SELECT fibonachi(40);

