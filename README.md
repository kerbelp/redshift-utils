# redshift-utils
A repo for different Redshift utilities that you might find helpful.

AWS have a great repo with great Redshift utilities.
You should check it out: https://github.com/awslabs/amazon-redshift-utils

All views assume you have a schema called admin.

| Query/View | Description |
| ------------- | ------------- |
| copies_run_time.sql |  A query displaying yesterdays average copy runtime in seconds | 
| current_locks.sql | A query displaying current locks |
| open_sessions.sql | A query displaying open sessions |
| running_queries.sql | A query displaying runninq queries |
| select_run_time.sql | A query displaying yesterdays average select query runtime in seconds |
| stl_load_errors.sql | A query displaying stl_load_errors by error by day |
| v_capacity_usage.sql | A view for overall capacity usage |
| v_usage_by_schema.sql | A view for displaying space usage by schema |
| v_usage_by_table.sql | A view for displaying space usage by table |
