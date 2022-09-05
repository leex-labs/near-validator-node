ALL_BACKUP_DIR=~/backups/
DATADIR=~/.near


if [ -d "$ALL_BACKUP_DIR" ]; then
    tar -xvf 
else
    echo $ALL_BACKUP_DIR is not created. Check your permissions.
    exit 0
fi
