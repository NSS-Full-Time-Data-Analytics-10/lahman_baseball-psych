--1) What range of years for baseball games played does the provided database cover? 1871 - 2016

SELECT MIN(yearid) AS earliest_year, MAX(yearid) AS latest_year
FROM teams;

--2) Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
-- Eddie Gaedel, 43 inches tall, 1, St. Louis Browns

SELECT namefirst, namelast, MIN(height)
FROM people
GROUP BY height,namefirst,namelast
ORDER BY height ASC
NULLS LAST
LIMIT 1;

SELECT p.namefirst,p.namelast,MIN(p.height),a.g_all,t.name
FROM people as p
INNER JOIN appearances as a ON p.playerid =a.playerid
INNER JOIN teams AS t ON a.teamid = t.teamid
GROUP BY p.namefirst,p.namelast,p.height,a.g_all,t.name
ORDER BY p.height
LIMIT 1;

--3) Find all players in the database who played at Vanderbilt University. 
--Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
--Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors? David Price, $81,851,296.00 

SELECT p.playerid, p.namefirst, p.namelast, SUM(s.salary::integer::money) AS total_earnings
FROM people AS p
JOIN salaries AS s USING (playerid)
	JOIN	(SELECT schoolid, playerid
			FROM people
			INNER JOIN collegeplaying USING (playerid)
			GROUP BY playerid, schoolid) AS c
			USING (playerid)
WHERE c.schoolid = 'vandy'
GROUP BY p.playerid, p.namefirst, p.namelast
ORDER BY total_earnings DESC;
		
