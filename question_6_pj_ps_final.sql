--QUESTION 6 Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful.
--(A stolen base attempt results either in a stolen base or being caught stealing.)
-- Consider only players who attempted _at least_ 20 stolen bases.
-- Chris Owings with 91.30%
SELECT people.playerid,people.namefirst, people.namelast,
ROUND(((batting.sb::numeric) / (batting.sb::numeric + batting.cs::numeric)) * 100, 2) AS success_rate
FROM batting
JOIN people USING (playerid)
WHERE yearid = 2016 AND  (sb) + (cs) >= 20
GROUP BY people.playerid,batting.sb::numeric,batting.cs::numeric,people.namelast, people.namefirst
ORDER BY
success_rate DESC;