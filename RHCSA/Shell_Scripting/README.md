# Shell Scripting: MySQL Backup and Automation

## Objective

This lab demonstrates how to create an automated backup process for MySQL databases using a shell script. The backup is stored with a date-based filename and executed daily using a cron job.

## Environment

- Operating System: Ubuntu (AWS EC2)
- User: ubuntu (with sudo privileges)
- Tools: `mysqldump`, `cron`

## Procedure

### 1. Create the Backup Directory

```bash
mkdir -p /root/mysql_backups
```

### 2. Write the Backup Script

Create a file named `backup_mysql.sh` and add the following content:

```bash
#!/bin/bash
BACKUP_DIR=/root/mysql_backups
DATE=$(date +%F)
FILENAME="MySQL_backup_$DATE.sql"
mysqldump -u root -p2023 --all-databases > "$BACKUP_DIR/$FILENAME"
```

Then make it executable:

```bash
chmod +x backup_mysql.sh
```

### 3. Set up the Cron Job

To schedule the script to run every day at 5:00 PM, use the crontab:

```bash
crontab -e
```

Then add this line:

```
0 17 * * * /root/mysql_backups/backup_mysql.sh
```

Verify the scheduled job:

```bash
crontab -l
```

## Included Files

- `backup_mysql.sh`: Shell script that runs the MySQL database backup.
- `cron_job.txt`: Contains the crontab entry used to automate the backup.

