/*
Lesson-6 / Vers.1 (22.08.2020)
========
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”. Работаем с БД vk и данными, которые вы сгенерировали ранее:
1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
*/


-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT 
count(*) AS message,
users.id ,
users.firstname,
users.lastname
FROM users, messages m2
WHERE
users.id = from_user_id
AND to_user_id = 1
GROUP BY users .id
ORDER BY message DESC LIMIT 1
;


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT 
count(*)
FROM likes
WHERE USER_id in 
	(SELECT 
	users .id
	FROM users, profiles
	WHERE users.id = profiles.user_id AND YEAR (now() ) - YEAR (profiles.birthday) < 10)
; -- AND (YEAR(now()) - YEAR(profiles.birthday) < 10;



-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
	(SELECT 
	count(user_id) 
	FROM likes l 
	WHERE user_id IN (SELECT 
		users .id
		FROM users, profiles
		WHERE users.id = profiles.user_id AND profiles.gender = 'f')) AS 'женщ',
			(SELECT 
	count(user_id) 
	FROM likes l 
	WHERE user_id IN (SELECT 
		users .id
		FROM users, profiles
		WHERE users.id = profiles.user_id AND profiles.gender = 'm')) AS 'мужч'
;	

-- вывод в строки с выбором максимума
SELECT 
Count(*) AS 'ЛАЙКИ',
CASE (user_id IN (SELECT 
			users .id
			FROM users, profiles
			WHERE users.id = profiles.user_id AND profiles.gender = 'f')) 
WHEN TRUE THEN 'женщ'
ELSE 'мужч'
END AS gender
FROM likes
GROUP BY gender 
ORDER BY 'лайки' DESC LIMIT 1
;