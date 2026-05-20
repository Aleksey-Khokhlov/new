/*добавьте сюда запросы для решения задания 6*/
BEGIN;

LOCK TABLE cafe.managers IN EXCLUSIVE MODE; -- Позволяет другим пользователям толь читать данные

ALTER TABLE cafe.managers ADD COLUMN phone TEXT[];

WITH new_numbers AS (
    SELECT 
        manager_uuid,
        CONCAT('8-800-2500-', ROW_NUMBER() OVER (ORDER BY manager_name) + 99) AS new_phone,
        manager_phone
    FROM cafe.managers
)
UPDATE cafe.managers
SET phone = ARRAY[nn.new_phone, nn.manager_phone]
FROM new_numbers nn
WHERE cafe.managers.manager_uuid = nn.manager_uuid;

ALTER TABLE cafe.managers DROP COLUMN manager_phone;

COMMIT;
