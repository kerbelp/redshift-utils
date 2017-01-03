 /*
 View for displaying users and groups.
 
 example:
 select * from admin.v_users_groups;

+----------+------------+-----------------+
| username |  usesuper  |      group      |
+----------+------------+-----------------+
|   admin  |    true    |     group_a     |
+----------+------------+-----------------+

*/

CREATE OR REPLACE VIEW admin.v_users_groups 
AS
SELECT derived_table1.username,
       derived_table1.usesuper,
       derived_table1."group"
FROM (SELECT u.usename AS username,
             u.usesuper,
             g.groname AS "group"
      FROM pg_group g
        LEFT JOIN pg_user u ON ( (',' || ARRAY_TO_STRING (g.grolist,',')) || ',') ~~ ( ('%,' || u.usesysid) || ',%')
      UNION
      SELECT u.usename AS username,
             u.usesuper,
             g.groname AS "group"
      FROM pg_group g
        RIGHT JOIN pg_user u ON ( (',' || ARRAY_TO_STRING (g.grolist,',')) || ',') ~~ ( ('%,' || u.usesysid) || ',%')) derived_table1
ORDER BY derived_table1.username,
         derived_table1."group";
