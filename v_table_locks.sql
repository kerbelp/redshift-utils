 /*
 A view for displaying locks by users.
 
 example:
 select * from admin.v_table_locks

 +----------+---------------+----------+-------------+-------+---------+-----------------+---------+
|  timetz  |    relname    | database | transaction |  pid  | usename |      mode       | granted |
+----------+---------------+----------+-------------+-------+---------+-----------------+---------+
| 17:39:16 | v_table_locks |   100072 |             | 19723 | admin   | AccessShareLock | true    |
+----------+---------------+----------+-------------+-------+---------+-----------------+---------+

*/

CREATE OR REPLACE VIEW admin.v_table_locks
(
  timetz,
  relname,
  database,
  transaction,
  pid,
  usename,
  mode,
  granted
)
AS 
 SELECT 'now'::character varying::time(6) with time zone AS timetz, c.relname, l."database", l."transaction", l.pid, a.usename, l."mode", l.granted
   FROM pg_locks l
   JOIN pg_class c ON c.oid = l.relation
   JOIN pg_stat_activity a ON a.procpid = l.pid AND c.relname !~~ 'pg_%'::character varying::text;