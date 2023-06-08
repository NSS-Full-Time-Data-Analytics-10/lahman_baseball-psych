--Q1.
SELECT MIN(yearid) AS start_year,MAX(yearid) AS end_year
FROM teams
--Q2.
SELECT p.namefirst,p.namelast,MIN(p.height) AS height,t.name as team,a.g_all
FROM people AS p
INNER JOIN appearances AS a
USING (playerid)
INNER JOIN teams AS t
USING (teamid)
GROUP BY p.namefirst,p.namelast,p.height,t.name,a.g_all
ORDER BY p.height ASC NULLS LAST
LIMIT 1;
--Q3.
SELECT CONCAT(p.namefirst,' ',p.namelast)AS name,SUM(s.salary::numeric::money) AS total_salary
FROM people AS p
JOIN salaries AS s
USING (playerid)
JOIN(SELECT schoolid,playerid
	FROM people
	JOIN collegeplaying
	USING (playerid)
    GROUP BY playerid,schoolid) AS c
	USING (playerid)
WHERE c.schoolid='vandy'
GROUP BY p.playerid
ORDER BY total_salary DESC;
