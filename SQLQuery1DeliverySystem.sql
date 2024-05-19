USE MASTER
GO
DROP DATABASE IF EXISTS DeliverySystem
GO
CREATE DATABASE DeliverySystem
GO
USE DeliverySystem
GO

-- Создание таблицы Клиенты
CREATE TABLE Clients (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL
) AS NODE;

-- Создание таблицы Склады
CREATE TABLE Warehouses (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL
) AS NODE;

-- Создание таблицы Транспортные средства
CREATE TABLE Vehicles (
    id INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL
) AS NODE;

-- Создание таблицы Заказы (связи между клиентами и товарами)
CREATE TABLE Orders (order_date DATETIME) AS EDGE;

-- Создание таблицы Поставки (связи между складами и товарами)
CREATE TABLE Deliveries (delivery_date DATETIME) AS EDGE;

-- Создание таблицы Маршруты доставки (связи между складами и транспортными средствами)
CREATE TABLE DeliveryRoutes (route_date DATETIME, distance INT) AS EDGE;

-- Заполнение таблицы Клиенты
INSERT INTO Clients (id, name, address) VALUES
(1, 'Client A', '123 Elm St'),
(2, 'Client B', '456 Oak St'),
(3, 'Client C', '789 Pine St'),
(4, 'Client D', '101 Maple St'),
(5, 'Client E', '202 Birch St'),
(6, 'Client F', '303 Cedar St'),
(7, 'Client G', '404 Spruce St'),
(8, 'Client H', '505 Willow St'),
(9, 'Client I', '606 Fir St'),
(10, 'Client J', '707 Ash St');

-- Заполнение таблицы Склады
INSERT INTO Warehouses (id, name, location) VALUES
(1, 'Warehouse 1', 'Central City'),
(2, 'Warehouse 2', 'Eastside'),
(3, 'Warehouse 3', 'Westside'),
(4, 'Warehouse 4', 'Northside'),
(5, 'Warehouse 5', 'Southside'),
(6, 'Warehouse 6', 'Downtown'),
(7, 'Warehouse 7', 'Uptown'),
(8, 'Warehouse 8', 'Suburb'),
(9, 'Warehouse 9', 'Industrial Area'),
(10, 'Warehouse 10', 'Rural Area');

-- Заполнение таблицы Транспортные средства
INSERT INTO Vehicles (id, type, capacity) VALUES
(1, 'Truck', 1000),
(2, 'Van', 500),
(3, 'Bike', 50),
(4, 'Drone', 10),
(5, 'Cargo Ship', 20000),
(6, 'Airplane', 10000),
(7, 'Train', 15000),
(8, 'Scooter', 20),
(9, 'Helicopter', 5000),
(10, 'Submarine', 8000);

-- Заполнение таблицы Заказы
INSERT INTO Orders ($from_id, $to_id, order_date)
VALUES 
((SELECT $node_id FROM Clients WHERE id = 1),
 (SELECT $node_id FROM Warehouses WHERE id = 1), '2024-05-01 08:00:00'),
((SELECT $node_id FROM Clients WHERE id = 2),
 (SELECT $node_id FROM Warehouses WHERE id = 2), '2024-05-02 09:00:00'),
((SELECT $node_id FROM Clients WHERE id = 3),
 (SELECT $node_id FROM Warehouses WHERE id = 3), '2024-05-03 10:00:00'),
((SELECT $node_id FROM Clients WHERE id = 4),
 (SELECT $node_id FROM Warehouses WHERE id = 4), '2024-05-04 11:00:00'),
((SELECT $node_id FROM Clients WHERE id = 5),
 (SELECT $node_id FROM Warehouses WHERE id = 5), '2024-05-05 12:00:00'),
((SELECT $node_id FROM Clients WHERE id = 6),
 (SELECT $node_id FROM Warehouses WHERE id = 6), '2024-05-06 13:00:00'),
((SELECT $node_id FROM Clients WHERE id = 7),
 (SELECT $node_id FROM Warehouses WHERE id = 7), '2024-05-07 14:00:00'),
((SELECT $node_id FROM Clients WHERE id = 8),
 (SELECT $node_id FROM Warehouses WHERE id = 8), '2024-05-08 15:00:00'),
((SELECT $node_id FROM Clients WHERE id = 9),
 (SELECT $node_id FROM Warehouses WHERE id = 9), '2024-05-09 16:00:00'),
((SELECT $node_id FROM Clients WHERE id = 10),
 (SELECT $node_id FROM Warehouses WHERE id = 10), '2024-05-10 17:00:00');

-- Заполнение таблицы Поставки
INSERT INTO Deliveries ($from_id, $to_id, delivery_date)
VALUES 
((SELECT $node_id FROM Warehouses WHERE id = 1),
 (SELECT $node_id FROM Warehouses WHERE id = 2), '2024-05-01 08:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 2),
 (SELECT $node_id FROM Warehouses WHERE id = 3), '2024-05-02 09:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 3),
 (SELECT $node_id FROM Warehouses WHERE id = 4), '2024-05-03 10:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 4),
 (SELECT $node_id FROM Warehouses WHERE id = 5), '2024-05-04 11:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 5),
 (SELECT $node_id FROM Warehouses WHERE id = 6), '2024-05-05 12:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 6),
 (SELECT $node_id FROM Warehouses WHERE id = 7), '2024-05-06 13:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 7),
 (SELECT $node_id FROM Warehouses WHERE id = 8), '2024-05-07 14:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 8),
 (SELECT $node_id FROM Warehouses WHERE id = 9), '2024-05-08 15:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 9),
 (SELECT $node_id FROM Warehouses WHERE id = 10), '2024-05-09 16:00:00'),
((SELECT $node_id FROM Warehouses WHERE id = 10),
 (SELECT $node_id FROM Warehouses WHERE id = 1), '2024-05-10 17:00:00');

-- Заполнение таблицы Маршруты доставки
INSERT INTO DeliveryRoutes ($from_id, $to_id, route_date, distance)
VALUES 
((SELECT $node_id FROM Warehouses WHERE id = 1),
 (SELECT $node_id FROM Vehicles WHERE id = 1), '2024-05-01 08:00:00', 50),
((SELECT $node_id FROM Warehouses WHERE id = 2),
 (SELECT $node_id FROM Vehicles WHERE id = 2), '2024-05-02 09:00:00', 30),
((SELECT $node_id FROM Warehouses WHERE id = 3),
 (SELECT $node_id FROM Vehicles WHERE id = 3), '2024-05-03 10:00:00', 10),
((SELECT $node_id FROM Warehouses WHERE id = 4),
 (SELECT $node_id FROM Vehicles WHERE id = 4), '2024-05-04 11:00:00', 5),
((SELECT $node_id FROM Warehouses WHERE id = 5),
 (SELECT $node_id FROM Vehicles WHERE id = 5), '2024-05-05 12:00:00', 100),
((SELECT $node_id FROM Warehouses WHERE id = 6),
 (SELECT $node_id FROM Vehicles WHERE id = 6), '2024-05-06 13:00:00', 500),
((SELECT $node_id FROM Warehouses WHERE id = 7),
 (SELECT $node_id FROM Vehicles WHERE id = 7), '2024-05-07 14:00:00', 200),
((SELECT $node_id FROM Warehouses WHERE id = 8),
 (SELECT $node_id FROM Vehicles WHERE id = 8), '2024-05-08 15:00:00', 15),
((SELECT $node_id FROM Warehouses WHERE id = 9),
 (SELECT $node_id FROM Vehicles WHERE id = 9), '2024-05-09 16:00:00', 80),
((SELECT $node_id FROM Warehouses WHERE id = 10),
 (SELECT $node_id FROM Vehicles WHERE id = 10), '2024-05-10 17:00:00', 300);

--Запросы с использованием функции MATCH
--Список всех клиентов и складов, с которыми они связаны через заказы:

 SELECT c.name AS ClientName, w.name AS WarehouseName
FROM Clients AS c
, Orders AS o
, Warehouses AS w
WHERE MATCH(c-(o)->w);

--Список всех складов и транспортных средств, связанных через маршруты доставки
SELECT w.name AS WarehouseName, v.type AS VehicleType
FROM Warehouses AS w
, DeliveryRoutes AS dr
, Vehicles AS v
WHERE MATCH(w-(dr)->v);

--Список всех складов и дат поставок товаров на эти склады:
SELECT w1.name AS FromWarehouse, w2.name AS ToWarehouse, d.delivery_date
FROM Warehouses AS w1
, Deliveries AS d
, Warehouses AS w2
WHERE MATCH(w1-(d)->w2);

--Список всех клиентов и дат их заказов:
SELECT c.name AS ClientName, o.order_date
FROM Clients AS c
, Orders AS o
, Warehouses AS w
WHERE MATCH(c-(o)->w);

--Список всех транспортных средств и складов, с которыми они связаны через маршруты доставки, с указанием расстояния:
SELECT v.type AS VehicleType, w.name AS WarehouseName, dr.distance
FROM Vehicles AS v
, DeliveryRoutes AS dr
, Warehouses AS w
WHERE MATCH(v<-(dr)-w);

--Запросы с использованием функции SHORTEST_PATH
--Найти кратчайший путь от склада до склада через поставки:
SELECT 
    w1.name AS FromWarehouse, 
    w2.name AS ToWarehouse,
    d.delivery_date AS DeliveryDate
FROM 
    Warehouses AS w1,
    Warehouses AS w2,
    Deliveries AS d
WHERE MATCH(w1-(d)->w2)
AND 
    w1.name = 'Warehouse 1';

--Найти кратчайший путь от склада до склада через поставки:
SELECT 
    w.name AS WarehouseName, 
    v.type AS VehicleType,
    dr.route_date AS RouteDate,
    dr.distance AS Distance
FROM 
    Warehouses AS w,
    Vehicles AS v,
    DeliveryRoutes AS dr
WHERE 
    MATCH(w-(dr)->v)
AND 
    w.name = 'Warehouse 1';






 