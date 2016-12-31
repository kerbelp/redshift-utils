/*

View for displaying recommended tables to vacuum.
 
example:
select * from admin.v_tables_to_vacuum

+----------------------------------+
|              query               |
+----------------------------------+
| VACUUM FULL schema.table_a       |
| VACUUM FULL schema.table_b       |
| VACUUM FULL schema.table_c       |
+----------------------------------+
*/

CREATE OR REPLACE VIEW admin.v_tables_to_vacuum 
AS
SELECT (('VACUUM FULL ' || derived_table1.schemaname) || '.') || derived_table1.tablename AS query
FROM (SELECT BTRIM(pgdb.datname) AS dbase_name,
             BTRIM(pgn.nspname) AS schemaname,
             BTRIM(a.name) AS tablename,
             a.id AS tbl_oid,
             b.mbytes AS megabytes,
             a. "rows" AS rowcount,
             a.unsorted_rows AS unsorted_rowcount,
             CASE
               WHEN a. "rows" = 0 THEN 0::DOUBLE precision
               ELSE ROUND(a.unsorted_rows::DOUBLE precision / a. "rows"::DOUBLE precision*100::DOUBLE precision,5::NUMERIC::NUMERIC(18,0))
             END AS pct_unsorted,
             CASE
               WHEN a. "rows" = 0 THEN 'n/a'
               WHEN (a.unsorted_rows::DOUBLE precision / a. "rows"::DOUBLE precision*100::DOUBLE precision) >= 20::DOUBLE precision THEN 'VACUUM recommended'
               ELSE 'n/a'
             END AS recommendation
      FROM (SELECT stv_tbl_perm.db_id,
                   stv_tbl_perm.id,
                   stv_tbl_perm.name,
                   SUM(stv_tbl_perm. "rows") AS "rows",
                   SUM(stv_tbl_perm. "rows") - SUM(stv_tbl_perm.sorted_rows) AS unsorted_rows
            FROM stv_tbl_perm
            GROUP BY stv_tbl_perm.db_id,
                     stv_tbl_perm.id,
                     stv_tbl_perm.name) a
        JOIN pg_class pgc ON pgc.oid = a.id::oid
        JOIN pg_namespace pgn ON pgn.oid = pgc.relnamespace
        JOIN pg_database pgdb ON pgdb.oid = a.db_id::oid
        LEFT JOIN (SELECT stv_blocklist.tbl,
                          COUNT(*) AS mbytes
                   FROM stv_blocklist
                   GROUP BY stv_blocklist.tbl) b ON a.id = b.tbl) derived_table1
WHERE derived_table1.megabytes IS NOT NULL
AND   derived_table1.recommendation = 'VACUUM recommended'
ORDER BY derived_table1.megabytes DESC;
