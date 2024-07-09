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

# Отримання токена адміністратора
ADMIN_TOKEN=$(curl -s -X GET "http://localhost:8086/api/v2/auth" -H "Authorization: Token $ADMIN_TOKEN" | grep -oP '(?<="token":")[^"]+')

# Відновлення резервної копії, якщо вона існує
if [ -d "$BACKUP_PATH" ]; then
  influx restore --full "$BACKUP_PATH" --token $ADMIN_TOKEN
fi

# Вбити фоновий процес InfluxDB
kill $PID

# Запуск InfluxDB у звичайному режимі
exec influxd
