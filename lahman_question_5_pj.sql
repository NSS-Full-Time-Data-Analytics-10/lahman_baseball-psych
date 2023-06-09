-- 5)
--Find the average number of strikeouts per game by decade since 1920. 
--Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
-- K's tend to increase per decade. I suspect this has a lot to do with analytics and available tech to see hitter's tendencies to react to certain pitches.
-- Also, there's an increase in homeruns AND strikeouts. I would assume this would play into the factor of the shift from 'small ball' to go big or go home mentality.

--PJ's code
SELECT 
(EXTRACT('decade'FROM TO_DATE(CAST(yearid AS VARCHAR), 'YYYY')) * 10)::INT AS decades,
 ROUND(AVG(so * 1.0/g)::NUMERIC,2) AS avg_ko_by_game,
 ROUND(AVG(hr * 1.0/g)::NUMERIC,2) as hr_per_game
 FROM teams
 WHERE yearid >= 1920
 GROUP BY decades
 ORDER BY decades;
 

--PS's code
SELECT CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
			WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
			WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
			WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
			WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
			WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
			WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
			WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
			WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
			WHEN yearid BETWEEN 2010 AND 2019 THEN '2010s'
			ELSE 'error' END AS decade,
			ROUND(AVG(soa * 1.0/g), 2) AS strikeouts_per_game,
	   		ROUND(AVG(HR * 1.0/g), 2) AS homeruns_per_game
FROM teams
WHERE yearid >= 1920
GROUP BY decade
ORDER BY decade ASC;



