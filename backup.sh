#!/bin/bash
set -e

DATE=$(date +%Y%m%d_%H%M%S)
FILENAME="js_${DATE}.sql.gz"
BACKUP_PATH="/backups/${FILENAME}"

echo "$(date): Iniciando backup → ${FILENAME}"

PGPASSWORD="${POSTGRES_PASSWORD}" pg_dump \
  -h "${POSTGRES_HOST:-js_bdjs}" \
  -U "${POSTGRES_USER:-postgres}" \
  "${POSTGRES_DB:-js}" | gzip > "${BACKUP_PATH}"

echo "$(date): Dump concluído ($(du -sh ${BACKUP_PATH} | cut -f1))"

rclone copy "${BACKUP_PATH}" "gdrive:${GDRIVE_FOLDER:-backups/postgres}/"
echo "$(date): Upload para Drive concluído"

find /backups -name "*.sql.gz" -mtime "+${KEEP_DAYS:-7}" -delete
echo "$(date): Limpeza local concluída"
