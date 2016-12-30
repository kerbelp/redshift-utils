 /*
 A view for displaying space usage by schema.
 
 example:
 select * from admin.v_space_by_schema

 database |   schema   |  mbytes_used  | usage_percent | usage_percent_including_free_space
----------+------------+---------------+---------------+-----------------------------------+
  dbname  |  schema_a  |      8000     |       60      |               80                  
  dbname  |  schema_b  |      1000     |       5       |               10                  
  dbname  |  schema_c  |      1000     |       5       |               10                  

*/

CREATE OR REPLACE VIEW admin.v_space_by_schema
AS
WITH CAPACITY AS
(
  SELECT SUM(capacity) FROM stv_partitions
),
USAGE AS
(
  SELECT TRIM(pgdb.datname) AS DATABASE,
         TRIM(pgn.nspname) AS SCHEMA,
         TRIM(a.name) AS TABLE,
         b.mbytes,
         a.rows
  FROM (SELECT db_id,
               id,
               name,
               SUM(ROWS) AS ROWS
        FROM stv_tbl_perm a
        GROUP BY db_id,
                 id,
                 name) AS a
    JOIN pg_class AS pgc ON pgc.oid = a.id
    JOIN pg_namespace AS pgn ON pgn.oid = pgc.relnamespace
    JOIN pg_database AS pgdb ON pgdb.oid = a.db_id
    JOIN (SELECT tbl, COUNT(*) AS mbytes FROM stv_blocklist GROUP BY tbl) b ON a.id = b.tbl
  ORDER BY mbytes DESC,
           a.db_id,
           a.name
)
SELECT DATABASE,
       SCHEMA,
       SUM(mbytes) AS mbytes_used,
       (SUM(mbytes)::double precision /(SELECT * FROM CAPACITY)*100) AS usage_percent,
       (SUM(mbytes)::double precision /(SELECT (SUM(CAPACITY) - SUM(used))
                                        FROM stv_partitions
                                        WHERE part_begin = 0)*100 +(SUM(mbytes)::double precision /(SELECT*FROM CAPACITY)*100)) AS usage_percent_including_free_space
FROM USAGE
GROUP BY DATABASE,
         SCHEMA
ORDER BY usage_percent DESC;
