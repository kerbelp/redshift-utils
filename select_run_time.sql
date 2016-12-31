 /*
 A query displaying yesterdays average select query runtime in seconds.
 
 result example:
 

     day    | hour |  select_query | avg_runtime_seconds |
------------+------+---------------+---------------------+
 2016-12-30 |   0  |   select ...  |          19         |
 2016-12-30 |   0  |   select ...  |          10         |

*/

SELECT day,
			 hour,
       select_query,
       AVG(run_time) avg_runtime
FROM (SELECT t.querytxt,
             TRUNC(starttime) as DAY,
             extract('hour' from starttime) as hour,
             datediff(SECOND,starttime,endtime) run_time,
             SUBSTRING(querytxt,0,CHARINDEX ('from',querytxt)) AS select_query
      FROM stl_query t
        JOIN stl_querytext USING (query)
      WHERE   TRUNC(starttime) >= TRUNC(SYSDATE -1)
        /*WHERE t.userid = (SELECT usesysid FROM pg_user WHERE usename = 'user')     */
      AND querytxt like 'select%'
)
GROUP BY day,
         hour,
         select_query
ORDER BY day, hour;