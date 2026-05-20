/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
Заполнение таблиц:

1. 

INSERT INTO cafe.restaurants (restaurant_name, restaurant_type, restaurant_menu)
SELECT DISTINCT
    s.cafe_name,
    s.type::cafe.restaurant_type,
    m.menu AS restaurant_menu
FROM raw_data.sales s
LEFT JOIN raw_data.menu m ON s.cafe_name = m.cafe_name;

2. 

INSERT INTO cafe.managers (manager_name, manager_phone)
SELECT DISTINCT
    manager AS manager_name,
    manager_phone
FROM raw_data.sales
WHERE manager IS NOT NULL;

3. INSERT INTO cafe.restaurant_manager_work_dates (restaurant_uuid, manager_uuid, start_date, end_date)
SELECT
    r.restaurant_uuid,
    m.manager_uuid,
    MIN(s.report_date) AS start_date,
    MAX(s.report_date) AS end_date
FROM raw_data.sales s
JOIN cafe.restaurants r ON s.cafe_name = r.restaurant_name
JOIN cafe.managers m ON s.manager = m.manager_name
GROUP BY r.restaurant_uuid, m.manager_uuid;

4.

INSERT INTO cafe.sales (date, restaurant_uuid, avg_check)
SELECT
    s.report_date AS date,
    r.restaurant_uuid,
    s.avg_check
FROM raw_data.sales s
JOIN cafe.restaurants r ON s.cafe_name = r.restaurant_name;/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
