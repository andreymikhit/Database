/*
Lesson-11 / Vers.1 (12.09.2020)
========

I. Практическое задание по теме “Оптимизация запросов”
I.1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
I.2) (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

II. Практическое задание по теме “NoSQL”
II.1) В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
II.2) При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
II.3) Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/


-- I. Практическое задание по теме “Оптимизация запросов”
-- I.1
USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(55) NOT NULL
) ENGINE = ARCHIVE;

-- Триггер на catalogs
DROP TRIGGER IF EXISTS looklog_catalogs;
DELIMITER //
CREATE TRIGGER looklog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;

-- Триггер на users
DROP TRIGGER IF EXISTS looklog_users;
DELIMITER //
CREATE TRIGGER looklog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;

-- Триггер на products
DROP TRIGGER IF EXISTS looklog_products;
DELIMITER //
CREATE TRIGGER looklog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;

-- Тест
SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Игровые девайсы'),
		('Устройства ввода'),
		('Аксессуары');

SELECT * FROM catalogs;
SELECT * FROM logs;


SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Чебурашка', '1956-01-01');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Rick', '1957-01-01'),
		('Morty', '1997-01-01'),
		('Beth', '1978-01-01'),
		('Jerry', '0000-00-01');

SELECT * FROM users;
SELECT * FROM logs;


SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('Джойстик ImbaKiller 3000', 'Игровые девайсы', 3700.00, 13),
		('Keyboard Logitech K350', 'Устройства ввода', 2500.00, 14),
		('Коврик', 'Коврик для мыши', 350.00, 15);

SELECT * FROM products;
SELECT * FROM logs;


--I.2
-- Cоздаtv тестовую таблицу


DROP TABLE IF EXISTS test_users; 
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday DATE,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
 	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS insert_users ;
DELIMITER //
CREATE PROCEDURE insert_users ()
BEGIN
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 1;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
DELIMITER ;


-- Тестим
SELECT * FROM test_users;

CALL insert_users();

SELECT * FROM test_users LIMIT 5;


-- II. Практическое задание по теме “NoSQL”
-- II.1

SADD ip '127.0.0.1' '127.0.0.2' '127.0.0.3'
// Невозможно добавить в коллекцию уже имеющейся в ней ip адрес, только уникальные значения
SADD ip '127.0.0.1' 
// просмотрим список уникальных ip
SMEMBERS ip
// кол-во адресов в коллекции
SCARD ip


-- II.2
set igor@simdyanov.ru igor 
set igor igor@simdyanov.ru

get igor@simdyanov.ru 
get igor


-- II.3
use products
db.products.insert({"name": "Intel Core i3-8100", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price": "7890.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}) 

db.products.insertMany([
	{"name": "AMD FX-8320", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD.", "price": "4780.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name": "AMD FX-8320E", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD.", "price": "4780.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}])

db.products.find().pretty()
db.products.find({name: "AMD FX-8320"}).pretty()


-- таблица catalogs
use catalogs
db.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Материнские платы"}, {"name": "Видеокарты"}])