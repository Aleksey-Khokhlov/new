1. 

CREATE SCHEMA cafe;

2.

CREATE TYPE cafe.restaurant_type AS ENUM (
    'coffee_shop',
    'restaurant',
    'bar',
    'pizzeria'
);

3.

CREATE TABLE cafe.restaurants (
	restaurant_uuid uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	restaurant_name VARCHAR(50) NOT NULL,
	restaurant_type cafe.restaurant_type NOT NULL,
	restaurant_menu JSONB
);

4.

CREATE TABLE cafe.managers (
	manager_uuid uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	manager_name varchar(50) NOT NULL,
	manager_phone varchar(50) NOT NULL
);

5. 


CREATE TABLE cafe.restaurant_manager_work_dates (
    restaurant_uuid UUID,
    manager_uuid UUID,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (restaurant_uuid, manager_uuid),
    FOREIGN KEY (restaurant_uuid) REFERENCES cafe.restaurants(restaurant_uuid),
    FOREIGN KEY (manager_uuid) REFERENCES cafe.managers(manager_uuid)
);

6. 

CREATE TABLE cafe.sales (
    date DATE,
    restaurant_uuid UUID,
    avg_check NUMERIC(6, 2),
    PRIMARY KEY (date, restaurant_uuid)
);/*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*//*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*/
