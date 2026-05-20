/*добавьте сюда запрос для решения задания 1*/


CREATE OR REPLACE VIEW cafe.top_3_restaurants_by_avg_check AS
SELECT
    restaurant_name AS "Название заведения",
    restaurant_type AS "Тип заведения",
    avg_check AS "Средний чек"
FROM (
    SELECT
        r.restaurant_name,
        r.restaurant_type::TEXT,
        ROUND(AVG(s.avg_check), 2) AS avg_check,
        ROW_NUMBER() OVER (
            PARTITION BY r.restaurant_type
            ORDER BY AVG(s.avg_check) DESC
        ) AS rn
    FROM cafe.sales s
    JOIN cafe.restaurants r ON s.restaurant_uuid = r.restaurant_uuid
    GROUP BY r.restaurant_uuid, r.restaurant_name, r.restaurant_type
) ranked
WHERE rn <= 3
ORDER BY "Тип заведения", "Средний чек" DESC;
