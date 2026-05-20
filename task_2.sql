/*добавьте сюда запрос для решения задания 2*/
CREATE MATERIALIZED VIEW cafe.change_of_avg_chek_by_year AS
WITH yearly_avg AS (
    SELECT
        r.restaurant_uuid,
        r.restaurant_name AS "Название заведения",
        r.restaurant_type::TEXT AS "Тип заведения",
        EXTRACT(YEAR FROM s.date) AS "Год",
        ROUND(AVG(s.avg_check), 2) AS "Средний чек в текущем году"
    FROM cafe.sales s
    JOIN cafe.restaurants r ON s.restaurant_uuid = r.restaurant_uuid
    WHERE EXTRACT(YEAR FROM s.date) != 2023
    GROUP BY r.restaurant_uuid, "Название заведения", "Тип заведения", "Год"
)
SELECT
    y."Год",
    y."Название заведения",
    y."Тип заведения",
    y."Средний чек в текущем году",
    LAG(y."Средний чек в текущем году") OVER (
        PARTITION BY y."Название заведения"
        ORDER BY y."Год"
    ) AS "Средний чек в предыдущем году",
    ROUND(
        (y."Средний чек в текущем году" - 
         LAG(y."Средний чек в текущем году") OVER (
             PARTITION BY y."Название заведения"
             ORDER BY y."Год"
         )) * 100.0 / 
         NULLIF(LAG(y."Средний чек в текущем году") OVER (
             PARTITION BY y."Название заведения"
             ORDER BY y."Год"
         ), 0),
        2
    ) AS "Изменение среднего чека в %"
FROM yearly_avg y
ORDER BY y."Название заведения", y."Год";
