 /*
 A query displaying current locks.
 
 result example:
 

 table_id |     last_update     | lock_owner |lock_owner_pid| lock_status  
----------+---------------------+------------+--------------+-------------+
  10023   | 2016-12-31 13:15:28 |  2342132   |     12032    | Holding write lock                      

*/


SELECT table_id,
       last_update,
       lock_owner,
       lock_owner_pid,
       lock_status
FROM stv_locks;