FROM debian:12-slim

RUN mkdir -p /etc/automysqlbackup/

RUN apt-get update  \
    && apt-get install -y mariadb-client mariadb-backup pigz xz-utils sudo curl \
    && curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash \
    && apt-get install -y mariadb-backup \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY run-backup.sh /app/run-backup.sh

ENTRYPOINT ["/app/run-backup.sh"]