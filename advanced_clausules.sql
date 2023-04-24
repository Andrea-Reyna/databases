##Clausulas avanzadas
#Mostrar el título de todas las series y el total de temporadas que tiene cada una de ellas.
SELECT ser.title, s.number FROM series ser LEFT JOIN seasons s ON ser.id = s.serie_id;
#Mostrar el nombre de todos los géneros y la cantidad total de películas por cada uno, siempre que sea mayor o igual a 3.alter
SELECT g.name, g.id as total FROM genres g RIGHT JOIN movies m ON g.id = m.genre_id;
SELECT g.name, count(m.genre_id) as total FROM genres g RIGHT JOIN movies m ON g.id = m.genre_id GROUP BY m.genre_id;
#Mostrar sólo el nombre y apellido de los actores que trabajan en todas las películas de la guerra de las galaxias y que estos no se repitan.
SELECT a.first_name, a.last_name 
FROM actors a
INNER JOIN actor_movie r ON a.id = r.actor_id 
INNER JOIN movies m ON r.movie_id = m.id 
WHERE m.title LIKE 'La Guerra de las Galaxias%' 
GROUP BY a.id;



##Consultas avanzadas - clase
-- DDL
CREATE DATABASE empresadb;
USE empresadb;

CREATE TABLE  `departamento`(
depto_nro VARCHAR(8) NOT NULL,
nombre_depto VARCHAR(50) NOT NULL,
localidad VARCHAR(50) NOT NULL,
PRIMARY KEY (`depto_nro`)
);

CREATE TABLE `empleado` (
  `cod_emp` VARCHAR(8) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `puesto` VARCHAR(50) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `salario` INT NOT NULL,
  `comision` INT NOT NULL,
  `depto_nro` VARCHAR(8) DEFAULT NULL,
  PRIMARY KEY (`cod_emp`),
  FOREIGN KEY (`depto_nro`) REFERENCES `departamento`(`depto_nro`)
);

-- DML 
INSERT INTO departamento (depto_nro, nombre_depto, localidad)
VALUES 
('D-000-1', 'Software', 'Los Tigres'),
('D-000-2', 'Sistemas', 'Guadalupe'),
('D-000-3', 'Contabilidad', 'La Roca'),
('D-000-4', 'Ventas', 'Plata');

INSERT INTO empleado (cod_emp, nombre, apellido, puesto, fecha_alta, salario, comision, depto_nro)
VALUES 
('E-0001', 'César', 'Piñero', 'Vendedor', '2018-05-12', 80000, 15000, 'D-000-4'),
('E-0002', 'Yosep', 'Kowaleski', 'Analista', '2015-07-14', 140000, 0, 'D-000-2'),
('E-0003', 'Mariela', 'Barrios', 'Director', '2014-06-05', 185000, 0, 'D-000-3'),
('E-0004', 'Jonathan', 'Aguilera', 'Vendedor', '2015-06-03', 85000, 10000, 'D-000-4'),
('E-0005', 'Daniel', 'Brezezicki', 'Vendedor', '2018-03-03', 83000, 10000, 'D-000-4'),
('E-0006', 'Mito', 'Barchuk', 'Presidente', '2014-06-05', 190000, 0, 'D-000-3'),
('E-0007', 'Emilio', 'Galarza', 'Desarrollador', '2014-08-02', 60000, 0, 'D-000-1');

#Seleccionar el nombre, el puesto y la localidad de los departamentos donde trabajan los vendedores.
SELECT e.nombre, e.puesto, d.localidad FROM empleado AS e INNER JOIN departamento AS d oN e.depto_nro = d.depto_nro;
#Visualizar los departamentos con más de cinco empleados.
SELECT d.nombre_depto FROM departamento AS d WHERE (SELECT COUNT(*) FROM empleado AS e WHERE e.depto_nro = d.depto_nro) >=3;

SELECT d.nombre_depto, COUNT(e.cod_emp) AS num_empleados
FROM departamento d
INNER JOIN empleado e ON d.depto_nro = e.depto_nro
GROUP BY d.nombre_depto
HAVING COUNT(e.cod_emp) > 2;

#Mostrar el nombre, salario y nombre del departamento de los empleados que tengan el mismo puesto que ‘Mito Barchuk’.
SELECT e.* FROM empleado AS e 
WHERE e.depto_nro = (
SELECT d.depto_nro FROM departamento AS d WHERE d.nombre_depto = "contabilidad")
ORDER BY e.nombre ASC;

#Mostrar los datos de los empleados que trabajan en el departamento de contabilidad, ordenados por nombre.
SELECT *
FROM empleado AS e 
WHERE e.depto_nro = (
SELECT d.depto_nro FROM departamento AS d WHERE d.nombre_depto = "contabilidad")
ORDER BY nombre;

#Mostrar el nombre del empleado que tiene el salario más bajo. 
SELECT e.nombre FROM empleado AS e WHERE e.salario = (SELECT MIN(e2.salario) FROM empleado as e2);

#Mostrar los datos del empleado que tiene el salario más alto en el departamento de ‘Ventas’.
SELECT e.* FROM empleado AS e INNER JOIN departamento as d oN e.depto_nro = d.depto_nro
WHERE d.nombre_depto = "ventas" AND e.salario = (
SELECT MAX (e2.salario) FROM empleados as e2 WHERE e2.depto_nro = d.depto_nro 
);

SELECT *
FROM empleado e
WHERE e.depto_nro = (
SELECT d.depto_nro FROM departamento AS d WHERE d.nombre_depto = "ventas")
ORDER BY salario DESC
LIMIT 1;

##2
CREATE DATABASE library;
USE library;

CREATE TABLE book (
  id_book INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  publisher VARCHAR(50) NOT NULL,
  area VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_book)
);

CREATE TABLE author (
  id_author INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  nationality VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_author)
);

CREATE TABLE bookauthor (
  id_book INT NOT NULL,
  id_author INT NOT NULL,
  PRIMARY KEY (id_book, id_author),
  FOREIGN KEY (id_book) REFERENCES book(id_book),
  FOREIGN KEY (id_author) REFERENCES author(id_author)
);

CREATE TABLE student (
  id_reader INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  major VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY (id_reader)
);


CREATE TABLE loan (
  id_reader INT NOT NULL,
  id_book INT NOT NULL,
  loan_date DATE NOT NULL,
  return_date DATE NOT NULL,
  returned BOOLEAN NOT NULL,
  PRIMARY KEY (id_reader, id_book),
  FOREIGN KEY (id_reader) REFERENCES student(id_reader),
  FOREIGN KEY (id_book) REFERENCES book(id_book)
);


INSERT INTO book (title, publisher, area)
VALUES 
('Harry Potter y la piedra filosofal', 'Salamandra', 'Fantasía'),
('El Universo: Guía de viaje', 'Alfredo Ortells', 'Ciencia ficción'),
('To Kill a Mockingbird', 'Lippincott', 'Fiction'),
('The Lord of the Rings', 'Allen & Unwin', 'Fantasy'),
('The Catcher in the Rye', 'Little, Brown and Company', 'Fiction'),
('The Hobbit', 'Allen & Unwin', 'Fantasy');

INSERT INTO author (name, nationality)
VALUES 
('J.K. Rowling', 'British'),
('Gustave Flaubert', 'French'),
('Italo Calvino', 'Italian'),
('J.R.R. Tolkien', 'English'),
('J.D. Salinger', 'American'),
('J.R.R. Tolkien', 'English');

INSERT INTO bookauthor (id_book, id_author)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO student (name, surname, address, major, age)
VALUES 
('John', 'Doe', '123 Main St', 'Computer Science', 22),
('Filippo', 'Galli', '456 Oak St', 'Informatica', 20),
('Bob', 'Smith', '789 Elm St', 'Mathematics', 21),
('Sarah', 'Jones', '101 Maple St', 'English', 23),
('Mike', 'Brown', '246 Walnut St', 'Biology', 19);

INSERT INTO loan (id_reader, id_book, loan_date, return_date, returned)
VALUES 
(1, 1, '2022-01-01', '2022-01-08', true),
(2, 2, '2022-02-01', '2022-02-08', true),
(3, 3, '2022-03-01', '2022-03-08', false),
(4, 4, '2022-04-01', '2022-04-08', false),
(5, 5, '2022-05-01', '2021-07-16', true);
 
 
#Listar los datos de los autores.
SELECT * FROM author;
#Listar nombre y edad de los estudiantes
SELECT name, age FROM student;
#¿Qué estudiantes pertenecen a la carrera informática?
SELECT * FROM student WHERE major = 'Informatica';
#¿Qué autores son de nacionalidad francesa o italiana?
SELECT *
FROM author
WHERE nationality IN ('French', 'Italian');
#¿Qué libros no son del área de internet?
SELECT *
FROM book
WHERE area <> 'Internet';
#Listar los libros de la editorial Salamandra.
SELECT *
FROM book
WHERE publisher = 'Salamandra';
#Listar los datos de los estudiantes cuya edad es mayor al promedio.
SELECT *
FROM student
WHERE age > (SELECT AVG(age) FROM student);
#Listar los nombres de los estudiantes cuyo apellido comience con la letra G.
SELECT name
FROM student
WHERE surname LIKE 'G%';
#Listar los autores del libro “El Universo: Guía de viaje”. (Se debe listar solamente los nombres).
SELECT a.name
FROM author a
INNER JOIN bookauthor r ON a.id_author = r.id_author
INNER JOIN book b ON b.id_book = r.id_book
WHERE b.title = 'El Universo: Guía de viaje';
#¿Qué libros se prestaron al lector “Filippo Galli”?
SELECT b.title
FROM book b
INNER JOIN loan l ON b.id_book = l.id_book
INNER JOIN student s ON s.id_reader = l.id_reader
WHERE s.name = 'Filippo' AND s.surname = 'Galli';
#Listar el nombre del estudiante de menor edad.
SELECT name
FROM student
ORDER BY age ASC
LIMIT 1;
#Listar nombres de los estudiantes a los que se prestaron libros de Base de Datos.
SELECT s.name
FROM student s
INNER JOIN loan l ON s.id_reader = l.id_reader
INNER JOIN book b ON b.id_book = l.id_book
WHERE b.area = 'Database';
#Listar los libros que pertenecen a la autora J.K. Rowling.
SELECT b.title
FROM book b
INNER JOIN bookauthor r ON b.id_book = r.id_book
INNER JOIN author a ON a.id_author = r.id_author
WHERE a.name = 'J.K. Rowling';
#Listar títulos de los libros que debían devolverse el 16/07/2021.
SELECT b.title
FROM book b
INNER JOIN loan l ON b.id_book = l.id_book
WHERE l.return_date = '2021-07-16';



