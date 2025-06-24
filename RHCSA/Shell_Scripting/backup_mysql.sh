#!/bin/bash
DATE=$(date +%F)
BACKUP_DIR="/home/ubuntu/mysql_backups"
mkdir -p "$BACKUP_DIR"
sudo mysqldump -u root your_db_name > "$BACKUP_DIR/MySQL_backup_$DATE.sql"
