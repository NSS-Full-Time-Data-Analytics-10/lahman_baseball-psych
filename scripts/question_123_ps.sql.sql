--1. What range of years for baseball games played does the provided database cover?  A:1871 - 2016
SELECT MIN(teams.yearid) as max_year, MAX(teams.yearid) AS min_year
FROM teams;

--2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
-- Eddie Gaedel, 43 inches tall, 1 game, played for St. Louis Browns
SELECT p.namefirst, p.namelast,MIN(p.height) AS shortest_player,t.name,a.g_all
FROM people AS p
INNER JOIN appearances AS a
USING (playerid)
INNER JOIN teams AS t
ON a.teamid = t.teamid
WHERE p.height IS NOT NULL
GROUP BY p.namefirst,p.namelast,t.name,a.g_all
ORDER BY shortest_player
LIMIT 1;

--3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total 
--salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in
--the majors?
SELECT *
FROM people;