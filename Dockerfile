FROM postgres:17-alpine

RUN apk add --no-cache \
    rclone \
    dcron \
    bash \
    tzdata

COPY entrypoint.sh /entrypoint.sh
COPY backup.sh /backup.sh
RUN chmod +x /entrypoint.sh /backup.sh && mkdir -p /backups

ENTRYPOINT ["/entrypoint.sh"]
