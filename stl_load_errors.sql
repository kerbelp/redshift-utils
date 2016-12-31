 /*
 A query displaying stl_load_errors by error by day.
 
 result example:
 

     day    | colname | err_reason  |    filename    |  amount
------------+---------+-------------+----------------+---------+
 2016-12-31 | column  | Overflow... | s3://file_path |    10

*/

SELECT TRUNC(starttime) as day,
       colname,
       err_reason,
       filename,
       COUNT(*) as amount
FROM stl_load_errors
WHERE filename LIKE '%s3_file_path%'
GROUP BY day,
         colname,
         err_reason,
         filename
ORDER BY day,
         colname,
         err_reason,
         filename;
