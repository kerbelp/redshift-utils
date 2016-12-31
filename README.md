# redshift-utils
### A repo for different Redshift utilities that you might find helpful.

AWS have a great repo with great Redshift utilities.
You should check it out: https://github.com/awslabs/amazon-redshift-utils

This repo contains more useful queries and views that I use on a daily basis.

All views assume you have a schema called admin.

| Query/View | Description |
| ------------- | ------------- |
| [copies_run_time.sql](copies_run_time.sql) |  Query displaying yesterdays average copy runtime in seconds | 
| [current_locks.sql](current_locks.sql) | Query displaying current locks |
| [open_sessions.sql](open_sessions.sql) | Query displaying open sessions |
| [running_queries.sql](running_queries.sql) | Query displaying runninq queries |
| [select_run_time.sql](select_run_time.sql) | Query displaying yesterdays average select query runtime in seconds |
| [stl_load_errors.sql](stl_load_errors.sql) | Query displaying stl_load_errors by error by day |
| [v_capacity_usage.sql](v_capacity_usage.sql) | View for overall capacity usage |
| [v_usage_by_schema.sql](v_usage_by_schema.sql) | View for displaying space usage by schema |
| [v_usage_by_table.sql](v_usage_by_table.sql) | View for displaying space usage by table |
