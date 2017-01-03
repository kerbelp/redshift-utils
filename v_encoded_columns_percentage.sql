 /*
 View for displaying percentage of encoded columns
 
 example:
 select * from admin.v_encoded_columns_percentage;

+------------+----------+--------------------+
| tablename  |  mbytes  | encoded_percentage |
+------------+----------+--------------------+
|  table_a   |   8300   |         1          |
+------------+----------+--------------------+
|  table_b   |   1300   |         0.7        |
+------------+----------+--------------------+
*/

CREATE OR REPLACE VIEW admin.v_encoded_columns_percentage 
AS
SELECT def.tablename,
       def.mbytes,
       SUM(CASE WHEN def.attencodingtype = 0 THEN 0 ELSE 1 END)::double precision / COUNT(DISTINCT def.attname)::double precision AS encoded_percentage
FROM (SELECT n.nspname AS schemaname,
             c.oid,
             c.relname AS tablename,
             format_encoding(a.attencodingtype) AS "encoding",
             a.attencodingtype,
             size.mbytes,
             a.attname
      FROM pg_namespace n,
           pg_class c,
           pg_attribute a,
           (SELECT stv_blocklist.tbl,
                   COUNT(*) AS mbytes
            FROM stv_blocklist
            GROUP BY stv_blocklist.tbl) size
      WHERE n.oid = c.relnamespace
      AND   c.oid = a.attrelid
      AND   a.attnum > 0
      AND   NOT a.attisdropped
      AND   c.oid = size.tbl) def
GROUP BY def.tablename,
         def.mbytes
ORDER BY def.mbytes DESC;
