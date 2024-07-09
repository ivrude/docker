When you up containers go to cmd influx and use command
influx restore /docker-entrypoint-initdb.d/influxdb-backup

To make backup use command
docker exec -it <influxdb_container_id> influx backup /backup
docker cp <influxdb_container_id>:/backup ./influxdb-backup
