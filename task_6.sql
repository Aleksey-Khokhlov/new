/*добавьте сюда запросы для решения задания 6*/

CREATE MATERIALIZED VIEW cafe.old_cofee_prices AS (
    SELECT 
        restaurant_uuid,
        restaurant_name,
        ROUND((restaurant_menu -> 'Кофе' ->> 'Капучино')::numeric) AS old_price
    FROM cafe.restaurants
    WHERE restaurant_menu ? 'Кофе' AND (restaurant_menu -> 'Кофе') ? 'Капучино'
); --это сделал просто для себя чтоб проверить


BEGIN;

SELECT 
    restaurant_uuid,
    restaurant_menu
FROM cafe.restaurants
WHERE restaurant_menu ? 'Кофе' AND (restaurant_menu -> 'Кофе') ? 'Капучино'
FOR UPDATE; --Исключает возможность влезть в изменения

WITH updated_prices AS (
    SELECT 
        restaurant_uuid,
        ROUND((restaurant_menu -> 'Кофе' ->> 'Капучино')::numeric * 1.2) AS new_price
    FROM cafe.restaurants
    WHERE restaurant_menu ? 'Кофе' AND (restaurant_menu -> 'Кофе') ? 'Капучино'
)

UPDATE cafe.restaurants r
SET restaurant_menu = jsonb_set(
    r.restaurant_menu,
    '{Кофе,Капучино}',
    to_jsonb(up.new_price)
)
FROM updated_prices up
WHERE r.restaurant_uuid = up.restaurant_uuid;

COMMIT;/*добавьте сюда запросы для решения задания 6*/
