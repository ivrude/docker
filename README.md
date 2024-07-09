Credentials

Ivan | p@ssw0rd

admin | p@ssw0rd

If u want to restore your own backup follow the next steps:

When you up containers go to the cmd influx and use command

```influx restore /docker-entrypoint-initdb.d/influxdb-backup```

To make a backup use the command

```docker exec -it <influxdb_container_id> influx backup /backup```

```docker cp <influxdb_container_id>:/backup ./influxdb-backup```
