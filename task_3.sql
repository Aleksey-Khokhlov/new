/*добавьте сюда запрос для решения задания 3*/
SELECT
    r.restaurant_name AS "Название заведения",
    COUNT(rm.manager_uuid) - 1 AS "Сколько раз менялся менеджер"
FROM cafe.restaurant_manager_work_dates rm
JOIN cafe.restaurants r ON rm.restaurant_uuid = r.restaurant_uuid
GROUP BY r.restaurant_uuid, r.restaurant_name
ORDER BY "Сколько раз менялся менеджер" DESC
LIMIT 3;
