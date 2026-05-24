#!/bin/bash
set -e

mkdir -p /root/.config/rclone
cat > /root/.config/rclone/rclone.conf <<EOF
[gdrive]
type = drive
token = ${RCLONE_GDRIVE_TOKEN}
EOF

echo "${BACKUP_SCHEDULE:-0 3 * * *} /backup.sh >> /var/log/backup.log 2>&1" > /etc/crontabs/root
echo "Cron configurado: ${BACKUP_SCHEDULE:-0 3 * * *}"

if [ "${RUN_ON_STARTUP:-false}" = "true" ]; then
  echo "Executando backup inicial..."
  /backup.sh
fi

exec crond -f -l 8
