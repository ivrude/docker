#!/bin/bash

# Шлях до резервної копії
BACKUP_PATH="/docker-entrypoint-initdb.d/influxdb-backup"

# Запуск InfluxDB у фоновому режимі
influxd &
PID=$!

# Очікування запуску InfluxDB
sleep 30

# Імпорт конфігурації
influx setup --skip-verify \
  --username Ivan \
  --password p@ssw0rd \
  --org Chornobyl \
  --bucket New \
  --retention 0 \
  --force

# Відновлення резервної копії, якщо вона існує
if [ -d "$BACKUP_PATH" ]; then
  influx restore --full "$BACKUP_PATH"
fi

# Вбити фоновий процес InfluxDB
kill $PID

# Запуск InfluxDB у звичайному режимі
exec influxd
