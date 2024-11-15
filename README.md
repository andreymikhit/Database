# Database
GeekBrains

---

### Database intro colab
sql3 <-> Colab

> https://colab.research.google.com/drive/...?usp=sharing

### Lesson 1 / HW
Задание
1. Приведите данные по преподавателям к третьей нормальной форме. В качестве отчёта сдайте таблицы с соответствующим содержимым в формате PDF. Рекомендуется выполнить это задание в программе, предназначенной для работы с таблицами — Microsoft Excel, OpenOffice Calc или другой, зависит от вашей рабочей системы. Затем выполните экспорт результата в файл формата PDF. Если такой программы у вас нет, создайте таблицы через сервис Google Docs или в любом текстовом редакторе.
Дополнительные пояснения к данным:
нумерация потоков сквозная;
поток определяет прохождение определенного курса некоторой группой учеников;
следующий курс для группы пойдёт уже другим потоком;
один ученик может закончить несколько курсов (потоков);
один преподаватель может вести разные курсы;
успеваемость учеников — оценка, выставленная преподавателем группе в целом по итогам выполнения проекта, также отражает вовлеченность группы в учебный процесс.
Пример таблички см. страница 15 в методичке.
2. Установите программу sqlite3, запустите её, выполните команду .help (точка плюс help). В качестве отчёта сдайте скриншот результата выполнения.
3. Дополнительное задание (выполняется по желанию): приведите данные по использованию социальных сетей к третьей нормальной форме.
Образец таблицы см. страница 15
Пояснение к значениям в таблице:
1 — использует активно;
2 — использует редко;

### Lesson 2 / HW
Задание
1. Создайте в SQLite базу данных преподавателей и назовите её teachers.db. В этой базе данных сформируйте таблицы преподавателей (teachers), курсов (courses), потоков (streams) и успеваемости (grades) на основе структур, которые представлены ниже. Обратите внимание, что данные вводить пока не надо. Сдайте отчет в виде файла базы данных teachers.db.
Образцы таблиц см. страница 14 в методичке
2. Дополнительное задание (выполняется по желанию): определите все связи между таблицами, созданными по результатам первого задания. Укажите, какой тип связи используется в каждом случае.

### Lesson 3 / HW
Задание
Работаем с базой данных teachers.db. В качестве отчёта сдайте команды, которые выполнялись (в текстовом файле), а также файл базы данных.
1. В таблице streams переименуйте столбец даты начала обучения в started_at.
2. В таблице streams добавьте столбец даты завершения обучения finished_at.
3. Приведите базу данных в полное соответствие с данными в таблицах из методички
### 4. Дополнительное задание (выполняется по желанию): в таблице успеваемости измените тип столбца «Ключ потока» на REAL. Выполните задание на таблице с данными.

### Lesson 4 / HW
Задание
Работаем с базой данных учителей teachers.db. Для каждого задания надо создать запрос, сдать нужно только код запросов в текстовом файле.
1. Преобразовать дату начала потока в таблице потоков к виду год-месяц-день. Используйте команду UPDATE.
2. Получите идентификатор и номер потока, запланированного на самую позднюю дату.
3. Покажите уникальные значения года по датам начала потоков обучения.
4. Найдите количество преподавателей в базе данных. Выведите искомое значение в столбец с именем total_teachers.
5. Покажите даты начала двух последних по времени потоков.
6. Найдите среднюю успеваемости учеников по потокам преподавателя с идентификатором равным 1.
7. Дополнительное задание (выполняется по желанию): найдите идентификаторы преподавателей, у которых средняя успеваемость по всем потокам меньше 4.8.

### Lesson 5 / HW
Задание
Работаем с базой данных учителей teachers.db. Для каждого задания создайте запрос, сдать нужно только код запросов в текстовом файле. Для решения воспользуйтесь вложенными запросами и UNION.
1. Найдите потоки, количество учеников в которых больше или равно 40. В отчет выведите номер потока, название курса и количество учеников.
2. Найдите два потока с самыми низкими значениями успеваемости. В отчет выведите номер потока, название курса, фамилию и имя преподавателя (одним столбцом), оценку успеваемости.
3. Найдите среднюю успеваемость всех потоков преподавателя Николая Савельева. В отчёт выведите идентификатор преподавателя и среднюю оценку по потокам.
4. Найдите потоки преподавателя Натальи Петровой, а также потоки, по которым успеваемость ниже 4.8. В отчёт выведите идентификатор потока, фамилию и имя преподавателя.
5. Дополнительное задание. Найдите разницу между средней успеваемостью преподавателя с наивысшим соответствующим значением и средней успеваемостью преподавателя с наименьшим значением. Средняя успеваемость считается по всем потокам преподавателя.

'''Задание 3:
1. Первый вложенный запрос не нужен, teacher_id есть в таблице основного запроса.
2. В условии основного запроса ошибка, должно быть FROM grades WHERE teacher_id = (SELECT id.'''

### Lesson 6 / HW
Задание
Работаем с базой данных учителей teachers.db. Для каждого из заданий требуется создать запрос, сдать надо только код запросов в текстовом файле. Для решений воспользуйтесь объединением JOIN, не используйте вложенные запросы и объединение UNION.
1. Покажите информацию по потокам. В отчет выведите номер потока, название курса и дату начала занятий.
2. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса.
3. Для всех учителей найдите среднюю оценку по всем проведённым потокам. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведенным потокам. Важно чтобы учителя, у которых не было потоков, также попали в выборку.
4. Дополнительное задание. Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем потокам преподавателя, название курса, который соответствует потоку с минимальным значением успеваемости, максимальное значение успеваемости по всем потокам преподавателя, название курса, соответствующий потоку с максимальным значением успеваемости, дату начала следующего потока.

'''Задание 3:
1. Левой в объединении должна быть таблица преподавателей, нам нужно получить в отчёт всех преподавателей.
2. Группировать строки лучше по значениям teachers.id, так как могут быть преподаватели без записей в таблице успеваемости.
Рекомендую доработать задание 3.'''

### Lesson 7 / HW
Задание
Работаем с базой данных учителей teachers.db. Для каждого задания надо сдать только код, который выполняется для получения результата, в текстовом файле.
1. Создайте представление, которое для каждого курса выводит название, номер последнего потока, дату начала обучения последнего потока и среднюю успеваемость курса по всем потокам.
2. Удалите из базы данных всю информацию, которая относится к преподавателю с идентификатором, равным 3. Используйте транзакцию.
3. Создайте триггер для таблицы успеваемости, который проверяет значение успеваемости на соответствие диапазону чисел от 0 до 5 включительно.
4. Дополнительное задание. Создайте триггер для таблицы потоков, который проверяет, что дата начала потока больше текущей даты, а номер потока имеет наибольшее значение среди существующих номеров. При невыполнении условий необходимо вызвать ошибку с информативным сообщением.

'''Задание 1:
Верный подход, только для streams.started_at также нужно найти MAX, это будет дата начала последнего потока каждого курса.'''

### Lesson 8 / HW
Задание
Работаем с базой данных учителей teachers.db. Для каждого задания требуется сдать только код, который выполняется для получения результата, в текстовом файле. В качестве отчёта к четвёртому заданию надо приложить скриншот.
1. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса. Решите задание с применением оконных функций.
2. Найдите среднюю оценку по всем потокам для всех учителей. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведённым потокам. Учителя, у которых не было потоков, также должны попасть в выборку. Решите задание с применением оконных функций.
3. Какие индексы надо создать для максимально быстрого выполнения представленного запроса?
SELECT
  surname,
  name,
  number,
  performance
FROM academic_performance
  JOIN teachers 
    ON academic_performance.teacher_id = teachers.id
  JOIN streams
    ON academic_performance.stream_id = streams.id
WHERE number >= 200;    
4. Установите SQLiteStudio, подключите базу данных учителей, выполните в графическом клиенте любой запрос.
5. Дополнительное задание. Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем потокам преподавателя, название курса, который соответствует потоку с минимальным значением успеваемости, максимальное значение успеваемости по всем потокам преподавателя, название курса, соответствующий потоку с максимальным значением успеваемости, дату начала следующего потока. Выполните задачу с использованием оконных функций.
