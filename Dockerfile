FROM alpine:3.19

RUN apk add --no-cache \
    postgresql-client \
    rclone \
    dcron \
    bash \
    tzdata

COPY entrypoint.sh /entrypoint.sh
COPY backup.sh /backup.sh
RUN chmod +x /entrypoint.sh /backup.sh && mkdir -p /backups

ENTRYPOINT ["/entrypoint.sh"]
