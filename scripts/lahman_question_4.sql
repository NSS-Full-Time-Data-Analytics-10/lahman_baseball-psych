SELECT pos
FROM fielding

SELECT SUM(po) AS putouts,
CASE WHEN pos='OF' THEN 'outfield'
     WHEN pos IN('SS','1B','2B','3B') THEN 'Infield'
	 WHEN pos IN('P','C') THEN 'Battery' END as position 
FROM fielding
WHERE yearid='2016'	
GROUP by position