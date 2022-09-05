#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
ARCHIVE_NAME="${DATE}.tar.gz"
DATADIR=~/.near
BACKUPDIR=~/.near-backup
ALL_BACKUP_DIR=~/backups/
mkdir $BACKUPDIR
mkdir $ALL_BACKUP_DIR

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts
    tar -czv -f ${ARCHIVE_NAME} $DATADIR/data/
    mv ${ARCHIVE_NAME} $ALL_BACKUP_DIR/
    rm $(ls -1t $ALL_BACKUP_DIR | tail -n +2)
    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/b50c726a-92a2-44c5-b9c4-a48768d825db

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts
