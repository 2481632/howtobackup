#!/bin/bash

# Check if user has passed config file
if [ $# -eq 0 ]
then
    echo "Usage: howtobackup CONFIGUTATION_FILE" 
    exit 1
fi

# Read user config file
source $1

# Backup dir name 
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
# Actual dir where new backup is stored
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
# Path to latest backup
readonly LATEST_LINK="${BACKUP_DIR}/latest"

# Create backup dir if not exist
mkdir -p "${BACKUP_DIR}"

# Use latest backup as the incremental base if it exists
if [ -d "$LATEST_LINK" ]
then
    OPTS="--link-dest $LATEST_LINK"
fi

# Execute rsync command and create incremental backup
rsync -a --info=STATS --delete \
    "${SOURCE_DIR}/" \
    $OPTS \
    --exclude=".cache" \
    "${BACKUP_PATH}" \
    --log-file="${BACKUP_DIR}/rsync.log"

# Set latest backup to newly created backup
rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"

# Execute anything the user wants to execute after creating backup
if [[ $(type -t exec_after) == function ]]; then
    exec_after
fi
