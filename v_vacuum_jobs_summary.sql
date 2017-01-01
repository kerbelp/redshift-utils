 /*
 View for displaying vacuum status.
 
 example:
 select * from admin.v_vacuum_jobs_summary

+----------+--------+---------------------+-----------+---------+-------------------+
| username |  name  |      eventtime      |    date   | status  | rows | sortedrows |
+----------+--------+---------------------+-----------+---------+------+------------+
|   admin  | table  | 2017-01-01 16:17:09 | 2017-01-01| skipped |   0  |      0     |
+----------+--------+---------------------+-----------+---------+------+------------+

*/

CREATE OR REPLACE VIEW admin.v_vacuum_jobs_summary
AS 
 SELECT DISTINCT us.username, perm.name, vac.eventtime, trunc(vac.eventtime) AS date, vac.status, vac."rows", vac.sortedrows
   FROM stl_vacuum vac
   JOIN stv_tbl_perm perm ON perm.id = vac.table_id
   JOIN pg_user us ON us.usesysid = vac.userid
  WHERE trunc(vac.eventtime) >= trunc('now'::timestamp without time zone - 1::bigint)
  ORDER BY vac.eventtime DESC;