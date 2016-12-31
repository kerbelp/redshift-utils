/*
A query for overall capacity usage 

Example result: 

capacity_gbytes | used_gbytes | free_gbytes |
----------------|-------------|-------------|
      17827     |     10789   |    7037     |
----------------|-------------|-------------|
*/
select
  sum(capacity) / 1024 as capacity_gbytes, 
  sum(used) / 1024 as used_gbytes, 
  (sum(capacity) - sum(used)) / 1024 as free_gbytes 
from 
  stv_partitions where part_begin = 0;