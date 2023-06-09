--9.



SELECT CONCAT(namefirst, ' ', namelast) AS manager, m.teamid, a.lgid, m.yearid
FROM managers AS m
INNER JOIN awardsmanagers AS a
	USING (playerid, yearid)
INNER JOIN people
	USING (playerid)
INNER JOIN (SELECT playerid
FROM awardsmanagers
WHERE awardid = 'TSN Manager of the Year'
	AND lgid IN ('AL', 'NL')
GROUP BY 1
HAVING COUNT(DISTINCT lgid) > 1
) AS winners
	USING (playerid)
WHERE awardid = 'TSN Manager of the Year'
	AND a.lgid IN ('AL', 'NL')
GROUP BY 1,2,3,4