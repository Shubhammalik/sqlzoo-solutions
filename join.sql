  /*
Q---1

The first example shows the goal scored by a player with the last name 'Bender'.
The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany.
To identify German players, check for: teamid = 'GER'
*/ 

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'


 /*
Q---2

Show id, stadium, team1, team2 for just game 1012
*/

SELECT id, stadium, team1, team2
FROM game WHERE id = 1012


 /*
Q---3

Show the player, teamid, stadium and mdate for every German goal.
*/ 

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'

 /*
Q---4

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/ 

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'


 /*
Q---5

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/

SELECT player, teamid, coach, gtime FROM goal
  JOIN eteam ON (teamid=id AND gtime<=10)


 /*
Q---6

List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/ 

SELECT mdate, teamname FROM game
  JOIN eteam ON (team1=eteam.id AND coach = 'Fernando Santos')


 /*
Q---7

List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/ 

SELECT player FROM goal
  JOIN game ON (id=matchid AND stadium = 'National Stadium, Warsaw')


 /*
Q---8

The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
*/ 

SELECT DISTINCT(player) FROM game
  JOIN goal ON matchid = id
  WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER')

 /*
Q---9

Show teamname and the total number of goals scored.
*/ 

SELECT teamname, count(player)
  FROM eteam JOIN goal ON (id=teamid)
   GROUP BY teamname


 /*
Q---10

Show the stadium and the number of goals scored in each stadium.
*/ 

SELECT stadium, COUNT(player) AS goals FROM game
  JOIN goal ON (id=matchid)
  GROUP BY stadium


 /*
Q---11

For every match involving 'POL', show the matchid, date and the number of goals scored.
*/ 

SELECT matchid, mdate, count(player) AS goals
  FROM game JOIN goal ON (matchid = id)
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate


 /*
Q---12

For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
*/ 

SELECT matchid, mdate, COUNT(matchid) AS goals
FROM game join
goal ON id = matchid
WHERE (team1 != 'GER' AND teamid = 'GER') OR 
( team2 != 'GER' AND teamid = 'GER')
GROUP BY matchid


 /*
Q---13

List every match with the goals scored by each team as shown.
This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0.
You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/ 

SELECT mdate, team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON (matchid = id)
 GROUP BY mdate, team1, team2
 ORDER BY mdate, matchid, team1, team2
