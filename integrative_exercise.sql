##Ejercicio integrador
CREATE DATABASE internet_company;

USE internet_company;

CREATE TABLE internet_plans (
plan_id INT PRIMARY KEY,
download_speed_mbps INT,
price DECIMAL(10,2),
discount DECIMAL(5,2)
);

CREATE TABLE customers (
dni INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
birthdate DATE,
province VARCHAR(50),
city VARCHAR(50),
plan_id INT,
FOREIGN KEY (plan_id) REFERENCES internet_plans(plan_id)
);

-- Inserting 5 records into the internet_plans table
INSERT INTO internet_plans (plan_id, download_speed_mbps, price, discount) VALUES
(1, 50, 49.99, 0),
(2, 100, 69.99, 0.1),
(3, 200, 89.99, 0.2),
(4, 500, 129.99, 0.25),
(5, 1000, 199.99, 0.3);

-- Inserting 10 records into the customers table
INSERT INTO customers (dni, first_name, last_name, birthdate, province, city, plan_id) VALUES
(11111111, 'John', 'Doe', '1985-06-20', 'California', 'Los Angeles', 2),
(22222222, 'Jane', 'Doe', '1990-08-15', 'California', 'San Francisco', 1),
(33333333, 'Bob', 'Smith', '1982-12-01', 'New York', 'New York City', 3),
(44444444, 'Alice', 'Johnson', '1977-03-10', 'Texas', 'Houston', 4),
(55555555, 'David', 'Lee', '1995-02-05', 'California', 'San Diego', 1),
(66666666, 'Karen', 'Kim', '1988-09-23', 'New Jersey', 'Jersey City', 5),
(77777777, 'Chris', 'Anderson', '1999-11-18', 'Texas', 'Austin', 2),
(88888888, 'Michael', 'Brown', '1980-07-07', 'Florida', 'Miami', 3),
(99999999, 'Amy', 'Garcia', '1993-04-28', 'California', 'San Francisco', 4),
(12345678, 'Tom', 'Wilson', '1975-01-15', 'Illinois', 'Chicago', 5);


#Mostrar todos los planes de internet disponibles, ordenados por velocidad de descarga de mayor a menor:
SELECT * FROM internet_plans ORDER BY download_speed_mbps DESC;
#Mostrar todos los clientes que tienen el plan de internet con el ID 3:
SELECT * FROM customers WHERE plan_id = 3;
#Mostrar el plan de internet más caro:
SELECT * FROM internet_plans ORDER BY price DESC LIMIT 1;
#Mostrar el nombre completo y la provincia de todos los clientes que viven en California:
SELECT CONCAT(first_name, ' ', last_name) AS full_name, province FROM customers WHERE province = 'California';
#Mostrar el número total de clientes que tenemos en nuestra base de datos:
SELECT COUNT(*) AS total_customers FROM customers;
#Mostrar todos los planes de internet que tienen algún descuento aplicado:
SELECT * FROM internet_plans WHERE discount > 0;
#Mostrar los nombres completos de los clientes que tienen un plan de internet con un descuento aplicado:
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers c
INNER JOIN internet_plans p ON c.plan_id = p.plan_id
WHERE p.discount > 0;
#Mostrar la velocidad de descarga y el precio de los tres planes de internet más rápidos:
SELECT download_speed_mbps, price FROM internet_plans ORDER BY download_speed_mbps DESC LIMIT 3;
#Mostrar los nombres completos de los clientes que tienen un plan de internet más rápido que 200 Mbps:
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers c
INNER JOIN internet_plans p ON c.plan_id = p.plan_id
WHERE p.download_speed_mbps > 200;
#Mostrar el número total de clientes que tenemos en cada provincia:
SELECT province, COUNT(*) AS total_customers FROM customers GROUP BY province;
