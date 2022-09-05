ALL_BACKUP_DIR=~/backups/
DATADIR=~/.near
echo "Unpack last backup to near data directory"

if [ -d "$ALL_BACKUP_DIR" ]; then
    UNPACK_FILE=$(find $ALL_BACKUP_DIR -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")
    echo "File to unpack: $UNPACK_FILE"
    tar -xzvf $UNPACK_FILE
else
    echo $ALL_BACKUP_DIR is not created. Check your permissions.
    exit 0
fi
