 /*
 View for displaying users and groups.
 
 example:
 select * from admin.v_users_groups;

+------------+-------------+--------------+
| group_name |  user_name  | is_superuser |
+------------+-------------+--------------+
|   group_a  |    user_a   |     true     |
+------------+-------------+--------------+

*/

CREATE OR REPLACE VIEW admin.v_users_groups 
AS
SELECT pg_group.groname as group_name,
       pg_user.usename as user_name,
       pg_user.usesuper as is_superuser
FROM pg_group,
     pg_user
WHERE pg_user.usesysid = ANY (pg_group.grolist);
