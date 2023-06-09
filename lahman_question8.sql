WITH attendance_parks as(SELECT DISTINCT parks.park_name, SUM(attendance/games::numeric)::integer AS attendance,team
				   FROM homegames
				   INNER JOIN parks
				   ON homegames.park=parks.park
				   WHERE year='2016' AND games>=10		 
				   GROUP BY park_name,team)

SELECT park_name,ROUND(AVG(attendance)) AS avg_attendance,team
FROM attendance_parks
GROUP BY park_name,team
ORDER BY avg_attendance DESC
LIMIT 5;
