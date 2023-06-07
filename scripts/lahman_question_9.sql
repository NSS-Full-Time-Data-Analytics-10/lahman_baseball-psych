WITH al AS(SELECT DISTINCT CONCAT(p.namefirst,' ',p.namelast) AS manager_name,p.playerid,t.name AS team_name,a.yearid
FROM AwardsManagers AS a
INNER JOIN people AS p
USING (playerid)
CROSS JOIN teams AS t
WHERE a.lgid IN ('NL') AND awardid='TSN Manager of the Year'
GROUP BY manager_name,p.playerid,t.name,a.yearid),

nl AS (SELECT DISTINCT CONCAT(p.namefirst,' ',p.namelast) AS manager_name,p.playerid,t.name
FROM AwardsManagers AS a
INNER JOIN people AS p
USING (playerid)
CROSS JOIN teams As t
WHERE a.lgid IN ('AL') AND awardid='TSN Manager of the Year'
GROUP BY manager_name,p.playerid,t.name,a.yearid)

SELECT DISTINCT al.manager_name, team_name,al.yearid
FROM al
INNER JOIN nl 
USING (playerid)


WITH al AS(SELECT DISTINCT CONCAT(p.namefirst,' ',p.namelast) AS manager_name,p.playerid,m.teamid AS team,a.yearid
FROM AwardsManagers AS a
INNER JOIN managers AS m
ON m.yearid=a.yearid
AND a.lgid=m.lgid
AND a.playerid=m.playerid
INNER JOIN people AS p
ON m.playerid=p.playerid
WHERE a.lgid IN ('NL') AND awardid='TSN Manager of the Year'),

nl AS (SELECT DISTINCT CONCAT(p.namefirst,' ',p.namelast) AS manager_name,p.playerid,m.teamid AS team,a.yearid
FROM AwardsManagers AS a
INNER JOIN managers AS m
ON a.yearid=m.yearid
AND a.lgid=m.lgid
AND a.playerid=m.playerid
INNER JOIN people AS p
ON m.playerid=p.playerid	   
WHERE a.lgid IN ('AL') AND awardid='TSN Manager of the Year')


SELECT DISTINCT al.manager_name,al.team,al.yearid
FROM al
INNER JOIN nl 
USING (playerid)

SELECT DISTINCT CONCAT(p.namefirst,' ',p.namelast) AS manager_name,p.playerid,m.teamid AS team,a.yearid
FROM AwardsManagers AS a
INNER JOIN managers AS m
ON a.yearid=m.yearid
AND a.lgid=m.lgid
AND a.playerid=m.playerid
INNER JOIN people AS p
ON m.playerid=p.playerid	   
WHERE a.lgid IN ('AL') AND awardid='TSN Manager of the Year'


SELECT awardsmanagers.playerid,CONCAT(people.namefirst,' ',people.namelast) AS manager_name,managers.teamid
FROM awardsmanagers
INNER JOIN managers
ON awardsmanagers.playerid=managers.playerid
INNER JOIN people
ON managers.playerid=people.playerid
WHERE awardsmanagers.lgid IN ('AL', 'NL')
GROUP BY awardsmanagers.playerid,manager_name,managers.teamid
HAVING COUNT(DISTINCT CASE WHEN awardsmanagers.lgid = 'AL' THEN awardsmanagers.yearid END) > 0
   AND COUNT(DISTINCT CASE WHEN awardsmanagers.lgid = 'NL' THEN awardsmanagers.yearid END) > 0;

