/*
Lesson-5 / Vers.1 (19.08.2020)
========
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
6. Подсчитайте средний возраст пользователей в таблице users
7. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
8. (по желанию) Подсчитайте произведение чисел в столбце таблицы
*/


-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


-- ответ
UPDATE users SET 
created_at = NOW(),
updated_at = NOW()
WHERE created_at IS NULL;


--Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- 1 вариант
UPDATE users SET
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'); 
UPDATE users SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- 2 вариант

ALTER TABLE users ADD new_created_at DATETIME, ADD new_updated_at DATETIME;

UPDATE users SET 
new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %l:%i'),
new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %l:%i');

ALTER TABLE users 
DROP created_at, 
DROP updated_at;
CHANGE new_created_at created_at DATETIME,
CHANGE new_updated_at updated_at DATETIME;


--В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- ответ

-- 1 вариант
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

-- 2 вариант
SELECT *,
IF(value=0,0,1) AS IDX
FROM storehouses_products ORDER BY IDX
;

--4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

-- 1 вариант
SELECT id, name, birthday_at FROM users WHERE (birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');

-- 2 вариант
SELECT users.firstname, users.lastname, profiles.birthday 
FROM users, profiles
WHERE 
IF(monthname(profiles.birthday) IN ('may', 'august'), 0, 1) != 1 
AND users.id = profiles.user_id; 

--5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

-- 1 вариант
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id,'5,1,2');

-- 2 вариант
SELECT *,
CASE from_user_id WHEN 1 THEN 1
		WHEN 5 THEN 0 
		WHEN 2 THEN 2 
		ELSE 10 END AS IDX
FROM messages m2 
WHERE from_user_id IN (5, 1, 2)
ORDER BY IDX
;

--6. Подсчитайте средний возраст пользователей в таблице users

-- 1 вариант
ALTER TABLE users ADD age INT NOT NULL;
UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());
SELECT AVG(age) FROM users;

-- 2 вариант
SELECT 
round(AVG(YEAR(NOW()) - Year(birthday)), 0) AS AGE
FROM profiles
;

--7. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

--1 вариант
SELECT CASE WEEKDAY(birthday_at) 
WHEN 0 THEN 'Понедельник' 
WHEN 1 THEN 'Вторник'
WHEN 2 THEN 'Среда' 
WHEN 3 THEN 'Четверг' 
WHEN 4 THEN 'Пятница' 
WHEN 5 THEN 'Суббота' 
WHEN 6 THEN 'Воскресенье' 
ELSE -1 END as wd, 
COUNT(birthday_at) as num 
FROM users 
GROUP BY wd ORDER BY FIELD(wd,'Понедельник','Вторник','Среда','Четверг','Пятница','Суббота','Воскресенье');

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day, COUNT(*) AS total FROM users GROUP BY day ORDER BY otal DESC;

-- 2 вариант
SELECT 
WEEKDAY(DATE_ADD(birthday, Interval (YEAR(NOW()) - YEAR(birthday)) YEAR)) AS d_num,
CASE
WEEKDAY(DATE_ADD(birthday, Interval (YEAR(NOW()) - YEAR(birthday)) YEAR))
WHEN 1 THEN 'Воскресенье'
WHEN 2 THEN 'Понедельник'
WHEN 3 THEN 'Вторник'
WHEN 4 THEN 'Среда'
WHEN 5 THEN 'Четверг'
WHEN 6 THEN 'Пятница'
ELSE 'Суббота' END AS DAY_Name,
count(WEEKDAY(DATE_ADD(birthday, Interval (YEAR(NOW()) - YEAR(birthday)) YEAR))) NUM
FROM profiles 
GROUP BY day_name 
ORDER BY d_num;

--8. (по желанию) Подсчитайте произведение чисел в столбце таблицы

-- 1 вариант
CREATE TABLE prod_num (id SERIAL PRIMARY KEY, value INT NULL );
INSERT INTO prod_num (value) VALUES -> (1), -> (2), -> (3), -> (4), -> (5);
SELECT exp(SUM(ln(value))) summ FROM prod_num;

-- 2 вариант
select exp(sum(ln(id))) from users
WHERE id < 6;
