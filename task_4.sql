/*добавьте сюда запрос для решения задания 4*/
WITH pizza_counts AS (
    SELECT
        r.restaurant_name AS "Название заведения",
        COUNT(*) AS pizza_count
    FROM cafe.restaurants r
    CROSS JOIN LATERAL jsonb_object_keys(r.restaurant_menu -> 'Пицца') AS p(pizza_name)
    WHERE r.restaurant_type = 'pizzeria'
    GROUP BY r.restaurant_name
),
ranked AS (
    SELECT
        "Название заведения",
        pizza_count AS "Количество пицц в меню",
        DENSE_RANK() OVER (ORDER BY pizza_count DESC) AS rnk
    FROM pizza_counts
)
SELECT
    "Название заведения",
    "Количество пицц в меню"
FROM ranked
WHERE rnk = 1
ORDER BY "Название заведения";

Какой вариант оптимальнее не этот и почему?:

SELECT
    "Название заведения",
    "Количество пицц в меню"
FROM (
    SELECT
        r.restaurant_name AS "Название заведения",
        COUNT(*) AS "Количество пицц в меню",
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM cafe.restaurants r
    CROSS JOIN LATERAL jsonb_object_keys(r.restaurant_menu -> 'Пицца') AS p(pizza_name)
    WHERE r.restaurant_type = 'pizzeria'
    GROUP BY r.restaurant_name
) AS ranked
WHERE rnk = 1
ORDER BY "Название заведения";
