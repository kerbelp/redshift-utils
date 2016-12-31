 /*
 A query displaying open sessions.
 
 result example:
 

       recordtime       | username  |   dbname   | remotehost |   pid  |  duration  
------------------------+-----------+------------+------------+--------+------------+
   2016-12-30 21:15:28  |  user_a   |   dbname   |  127.0.0.1 |  2002  |     0                  

*/

SELECT recordtime,
       username,
       dbname,
       remotehost,
       remoteport,
       pid,
       duration
FROM stl_connection_log
WHERE event = 'initiating session'
AND   pid NOT IN (SELECT pid
                  FROM stl_connection_log
                  WHERE event = 'disconnecting session')
ORDER BY 1 DESC;