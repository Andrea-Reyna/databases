USE movies_db;
##Tablas temporales
#Ejercicio 1: Con la base de datos “movies”, se propone crear una tabla temporal llamada “TWD” y guardar en la misma los episodios de todas las temporadas de “The Walking Dead”.
#TWD Serie ID = 3
CREATE TEMPORARY TABLE TWD AS 
SELECT e.title as episode,e.rating as rating, e.release_date as start_date, sea.number as number_of_season
FROM series s
INNER JOIN seasons sea ON s.id = sea.serie_id
INNER JOIN episodes e ON e.season_id = sea.id
WHERE s.id = 3;

#Realizar una consulta a la tabla temporal para ver los episodios de la primera temporada.
SELECT * from TWD WHERE number_of_season = 1;

#Ejercicio 2: #En la base de datos “movies”, seleccionar una tabla donde crear un índice y luego chequear la creación del mismo. 
#Analizar por qué crearía un índice en la tabla indicada y con qué criterio se elige/n el/los campos.
CREATE INDEX genre_index ON movies_db.movies(genre_id);
CREATE INDEX movies_rating ON movies_db.movies (rating);
CREATE INDEX actors_rating ON movies_db.actors (rating);
SHOW INDEXES FROM movies_db.movies;
SHOW INDEXES FROM movies_db.genres;

#Agregar una película a la tabla movies.
INSERT INTO movies (created_at, updated_at, title, rating, awards, release_date, length, genre_id)
VALUES (NULL, NULL, 'The Adventure of the Lost Key', 7.8, 2, '2023-05-01 00:00:00', 120, 2);
SELECT * FROM movies;
#Agregar un género a la tabla genres.
INSERT INTO genres (created_at, updated_at, name, ranking, active)
VALUES ('2013-07-04 03:00:00', NULL, 'Mystery', 13, 1);
SELECT * FROM genres;
#Asociar a la película del punto 1. genre el género creado en el punto 2.
UPDATE movies SET genre_id = 19 WHERE id = 22;
#Modificar la tabla actors para que al menos un actor tenga como favorita la película agregada en el punto 1.
UPDATE actors SET favorite_movie_id = 23 WHERE id = 5;

#Crear una tabla temporal copia de la tabla movies.
CREATE TEMPORARY TABLE movies_temp 
SELECT * FROM movies;
#Eliminar de esa tabla temporal todas las películas que hayan ganado menos de 5 awards.
DELETE FROM movies_temp WHERE awards < 5;
#Obtener la lista de todos los géneros que tengan al menos una película.
SELECT DISTINCT g.name FROM genres g INNER JOIN movies_temp m ON g.id = m.genre_id;
#Obtener la lista de actores cuya película favorita haya ganado más de 3 awards.
SELECT a.first_name, a.last_name, a.favorite_movie_id, m.title, m.awards FROM actors a INNER JOIN movies m ON m.id = a.favorite_movie_id WHERE m.awards > 3;

#Crear un índice sobre el nombre en la tabla movies.
CREATE INDEX movies_title ON movies_db.movies (title);

#Chequee que el índice fue creado correctamente.
SHOW INDEXES FROM movies_db.movies;
