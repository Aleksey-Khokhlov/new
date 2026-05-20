/*добавьте сюда запрос для решения задания 5*/

WITH menu_cte AS (
    SELECT
        r.restaurant_name AS "Название заведения",
        'Пицца' AS "Тип блюда",
        p.key AS "Название пиццы", 
        p.value AS "Цена"
    FROM cafe.restaurants r
    CROSS JOIN LATERAL jsonb_each_text(r.restaurant_menu -> 'Пицца') AS p(key, value)
    WHERE r.restaurant_type = 'pizzeria'
), menu_with_rank AS (
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY "Название заведения" ORDER BY "Цена" DESC) AS rn
	FROM menu_cte
) SELECT 
	"Название заведения",
    "Тип блюда",
    "Название пиццы", 
    "Цена"
    FROM menu_with_rank 
    WHERE rn = 1
    ORDER BY "Название заведения";/*добавьте сюда запрос для решения задания 5*/
