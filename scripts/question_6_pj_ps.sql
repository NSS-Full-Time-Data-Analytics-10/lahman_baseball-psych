--6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are 
--successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
SELECT people.playerid,people.namefirst, people.namelast,
ROUND((batting.sb::numeric - batting.cs::numeric) / (batting.sb::numeric) * 100 , 2) AS success_rate
FROM batting
JOIN people USING (playerid)
WHERE yearid = 2016
GROUP BY people.playerid,batting.sb::numeric,batting.cs::numeric,people.namelast, people.namefirst
HAVING batting.sb::numeric >= 20
ORDER BY
success_rate DESC
LIMIT 1;
