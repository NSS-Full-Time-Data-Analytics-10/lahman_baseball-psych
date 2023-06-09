--10. 

 
SELECT p.namefirst, p.namelast, b.hr AS max_home_runs
FROM people AS p
INNER JOIN (
    SELECT playerid, MAX(hr) AS hr
    FROM batting
    WHERE yearid = 2016
    GROUP BY playerid
    ) AS b
	ON p.playerid = b.playerid
WHERE
    b.hr > 0
    AND b.hr = (
        SELECT MAX(hr)
        FROM batting
        WHERE playerid = p.playerid
        GROUP BY playerid
    )
    AND (
        SELECT COUNT(DISTINCT yearid)
        FROM batting
        WHERE playerid = p.playerid
    ) >= 10;