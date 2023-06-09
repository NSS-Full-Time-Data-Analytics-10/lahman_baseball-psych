46
--Q7 From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?
--Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case.
--Then redo your query, excluding the problem year.
--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?
SELECT *
FROM teams
WHERE wswin = 'N' AND yearid BETWEEN 1970 AND 2016
ORDER BY w DESC
LIMIT 1;

---- What is the smallest number of wins for a team that did win the world series?
SELECT *
FROM teams
WHERE wswin = 'Y' AND (yearid BETWEEN 1970 AND 2016) AND NOT (yearid = 1981)
ORDER BY w ASC
LIMIT 1;

----How often from 1970 – 2016 was it the case that a team with the most wins also won the world series?  12 Teams
WITH maxwin AS (SELECT yearid,MAX(w) AS help      -- first CTE list for practicing and referencing purposes
	   			FROM teams
	   			WHERE yearid  >= 1970
	   			GROUP BY yearid)
SELECT yearid,w
FROM maxwin
INNER JOIN teams USING (yearid)
WHERE wswin = 'Y' AND w = help
ORDER BY yearid ASC;

--What percentage of the time?  26.09%
WITH dangoldang AS (WITH maxwin AS (SELECT yearid,MAX(w) AS max_w
	   			FROM teams
	   			WHERE yearid  >= 1970
	   			GROUP BY yearid)
SELECT name,yearid,w,max_w,(CASE WHEN w = max_w THEN 1    --- Using CASE WHEN statement for aggregation regarding percentages
ELSE 0 END) AS ws_and_most_wins
FROM maxwin
INNER JOIN teams USING (yearid)
WHERE wswin = 'Y'
ORDER BY yearid ASC)
SELECT ROUND((SUM(ws_and_most_wins)::numeric/COUNT(*))*100,2) AS ws_percentage_and_maxw FROM dangoldang    --- using round and percentage functions to calculate requested %