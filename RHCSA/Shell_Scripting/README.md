# Shell Scripting: MySQL Backup and Automation

## Objective

This lab demonstrates how to create an automated backup process for MySQL databases using a shell script. The backup is stored with a date-based filename and executed daily using a cron job.

## Environment

- Operating System: Ubuntu (AWS EC2)
- User: ubuntu (with sudo privileges)
- Tools: `mysqldump`, `cron`

## Procedure

### 1. Install MySQL Server

```bash
sudo apt update
sudo apt install mysql-server -y
```

### 3. Create Backup Directory

```bash
sudo mkdir -p /root/mysql_backups
```

### 4. Write the Backup Script

Create the script:

```bash
nano backup_mysql.sh
```

 Save the script in this folder:
- [backup_mysql.sh](backup_mysql.sh)

Make it executable:

```bash
chmod +x backup_mysql.sh
```

### 6. Set Up Cron Job

```bash
crontab -e
```

Add:

```
0 17 * * * /home/ubuntu/iVolve-OTJ/RHCSA/Shell_Scripting/backup_mysql.sh
```

Export the cron config:
- [cron_job.txt](cron_job.txt)

---

## Files

- [backup_mysql.sh](backup_mysql.sh)
- [cron_job.txt](cron_job.txt)

