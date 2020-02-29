  /*
Q---1

List the films where the yr is 1962 [Show id, title]
*/ 

SELECT id, title FROM movie
  WHERE yr=1962


 /*
Q---2

Give year of 'Citizen Kane'.
*/

SELECT yr FROM movie
  WHERE title = 'Citizen Kane'


 /*
Q---3

List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
Order results by year.
*/ 

SELECT id, title, yr FROM movie
  WHERE title LIKE '%star trek%'
  ORDER BY yr


 /*
Q---4

What id number does the actor 'Glenn Close' have?
*/ 

SELECT id FROM actor
  WHERE name = 'Glenn Close'


 /*
Q---5

What is the id of the film 'Casablanca'
*/

SELECT id FROM movie
  WHERE title = 'Casablanca'


 /*
Q---6

Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/ 

SELECT name FROM actor
INNER JOIN casting ON (id = actorid)
  WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca')


 /*
Q---7

Obtain the cast list for the film 'Alien'
*/ 

SELECT name FROM actor
INNER JOIN casting ON (id = actorid
  AND movieid = 
    (SELECT id FROM movie WHERE title = 'Alien'))

 /*
Q---8

List the films in which 'Harrison Ford' has appeared
*/ 

SELECT title FROM movie
  WHERE id IN
  (SELECT movieid FROM casting 
    JOIN actor ON (id=actorid)
    WHERE name = 'Harrison Ford' )



 /*
Q---9

List the films where 'Harrison Ford' has appeared - but not in the starring role.
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/ 

SELECT title FROM movie
where id IN
(SELECT movieid FROM casting 
JOIN actor ON id=actorid
WHERE name =  'Harrison Ford' AND ord<>1)


 /*
Q---10

List the films together with the leading star for all 1962 films.
*/ 

SELECT title, name FROM movie m
  JOIN casting ON m.id = movieid 
  JOIN actor a on a.id = actorid
  WHERE yr = 1962 AND ord = 1


 /*
Q---11

Which were the busiest years for 'Rock Hudson', show the year and the number of movies
he made each year for any year in which he made more than 2 movies.
*/ 

SELECT yr, count(title) AS number FROM movie m
  JOIN casting ON m.id=movieid 
  JOIN actor a on a.id=actorid
  WHERE name = 'Rock Hudson' 
  GROUP BY yr
  HAVING number > 2


 /*
Q---12

List the film title and the leading actor for all of the films 'Julie Andrews' played in.
Did you get "Little Miss Marker twice"?
*/ 

SELECT title, name FROM movie m
  JOIN casting ON (m.id=movieid)
  JOIN actor a on (a.id=actorid)
  WHERE ord = 1 AND movieid IN
    (SELECT movieid FROM movie m
      JOIN casting ON (m.id=movieid)
      JOIN actor a on (a.id=actorid)
      WHERE name = 'Julie Andrews' )


 /*
Q---13

Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/ 

SELECT name FROM actor a
JOIN casting ON ( actorid = id AND
                    (SELECT count(ord) FROM casting
                       WHERE ord = 1 AND actorid = a.id) >= 15)
 GROUP BY name


 /*
Q---14

List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/ 

SELECT title, COUNT(actorid) as cast FROM movie
  JOIN casting ON id = movieid
  WHERE yr = 1978
  GROUP BY title
  ORDER BY cast DESC, title


 /*
Q---15

List all the people who have worked with 'Art Garfunkel'.
*/ 

SELECT name FROM actor
  JOIN casting ON id = actorid
  WHERE movieid IN (
    SELECT movieid FROM casting 
      WHERE actorid = 
        (SELECT id FROM actor WHERE name = 'Art Garfunkel'))
  AND name<> 'Art Garfunkel'


