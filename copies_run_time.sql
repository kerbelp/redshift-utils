 /*
 A query displaying yesterdays average copy runtime in seconds.
 
 result example:
 

     day    | hour |     copy_table      | avg_runtime_seconds |
------------+------+---------------------+---------------------+
 2016-12-30 |   0  | copy schema.table_a |          190        |
 2016-12-30 |   0  | copy schema.table_b |          20         |

*/

SELECT day,
       hour,
       copy_table,
       AVG(run_time) avg_runtime
FROM (SELECT t.querytxt,
             TRUNC(starttime) as DAY,
             extract('hour' from starttime) as hour,
             datediff(SECOND,starttime,endtime) run_time,
             SUBSTRING(querytxt,0,CHARINDEX ('from',querytxt)) AS copy_table
      FROM stl_query t
        JOIN stl_querytext USING (query)
      WHERE   TRUNC(starttime) >= TRUNC(SYSDATE -1)
        /*WHERE t.userid = (SELECT usesysid FROM pg_user WHERE usename = 'user')     */
      AND querytxt like 'copy%'
)
GROUP BY day,
         hour,
         copy_table
ORDER BY day, hour;