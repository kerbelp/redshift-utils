 /*
 A query displaying runninq queries.
 
 result example:
 

    pid   | user_name  |        starttime        | mins_duration |       query
----------+------------+-------------------------+---------------+-----------------------+
   20032  |   user_a   | 2016-12-30 21:15:28     |       15      |   select * from                  

*/

SELECT pid,
       TRIM(user_name) AS user_name,
       starttime,
       datediff(minute,starttime,sysdate) AS mins_duration,
       SUBSTRING(query,1,400) AS query
FROM stv_recents
WHERE status = 'Running'
ORDER BY user_name DESC;