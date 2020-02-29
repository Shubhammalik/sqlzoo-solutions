 /*
Q---1

Show the total population of the world.
*/ 

SELECT SUM(population) as total_population
  FROM world

 /*
Q---2

List all the continents - just once each.
*/

SELECT DISTINCT continent FROM world

 /*
Q---3

Give the total GDP of Africa
*/ 

SELECT SUM(gdp) FROM world 
  WHERE continent ='Africa'


 /*
Q---4

How many countries have an area of at least 1000000
*/ 

SELECT COUNT(name) FROM world 
  WHERE area >= 1000000


 /*
Q---5

What is the total population of ('Estonia', 'Latvia', 'Lithuania')
*/

SELECT SUM(population)
  FROM world
  WHERE name IN ('Estonia', 'Latvia', 'Lithuania')


 /*
Q---6

For each continent show the continent and number of countries.
*/ 

SELECT continent, count(name)
  FROM world
  GROUP BY continent

 /*
Q---7

For each continent show the continent and number of countries with populations of at least 10 million.
*/ 

SELECT continent, count(name)
  FROM world
  WHERE population >= 10000000
  GROUP BY continent


 /*
Q---8

List the continents that have a total population of at least 100 million.
*/ 

SELECT continent
  FROM world
  GROUP BY continent
  HAVING sum(population) > 100000000
