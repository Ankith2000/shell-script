#!/bin/bash

##########################################
# 01. Service Health Check Script
##########################################
SERVICE="nginx"
if systemctl is-active --quiet $SERVICE; then
  echo "$SERVICE is running"
else
  echo "$SERVICE is not running, starting..."
  systemctl start $SERVICE
fi

##########################################
# 02. Disk Space Monitor Script
##########################################
THRESHOLD=80
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $USAGE -gt $THRESHOLD ]; then
  echo "Disk space critical: ${USAGE}% used!" | mail -s "Disk Space Alert" admin@example.com
fi

##########################################
# 03. Backup Directory Script
##########################################
BACKUP_DIR="/backup"
SOURCE_DIR="/var/www/html"
DATE=$(date +%F)
tar -czvf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE_DIR

##########################################
# 04. Create Users from File
##########################################
while read user; do
  useradd $user && echo "User $user created"
done < users.txt

##########################################
# 05. Log Cleanup Script
##########################################
find /var/log -name "*.log" -type f -mtime +7 -exec rm -f {} \;

##########################################
# 06. Install Multiple Packages
##########################################
PACKAGES="nginx docker git"
for package in $PACKAGES; do
  apt-get install -y $package
done

##########################################
# 07. System Update Script
##########################################
apt-get update -y && apt-get upgrade -y

##########################################
# 08. Docker Container Status
##########################################
docker ps -a

##########################################
# 09. Code Deploy Script
##########################################
cd /var/www/project
git pull origin main
systemctl restart nginx

##########################################
# 10. Jenkins Build Trigger
##########################################
curl -X POST http://jenkins.example.com/job/YourJob/build --user user:APITOKEN

##########################################
# 11. SSH Key Setup on Remote Server
##########################################
ssh-copy-id user@remote-server

##########################################
# 12. Cron Job Setup Script
##########################################
echo "0 2 * * * /path/to/backup.sh" >> /var/spool/cron/crontabs/root

##########################################
# 13. CPU & Memory Monitor
##########################################
TOP_USAGE=$(top -b -n1 | head -5)
echo "$TOP_USAGE"

##########################################
# 14. Load Testing Script
##########################################
ab -n 100 -c 10 http://yourserver.com/

##########################################
# 15. MySQL Database Backup
##########################################
mysqldump -u root -pYourPassword database_name > /backup/db_backup.sql

##########################################
# 16. NGINX Restart on Failure
##########################################
if ! pgrep nginx > /dev/null; then
  systemctl start nginx
fi

##########################################
# 17. Failed Login Attempts Monitor
##########################################
grep "Failed password" /var/log/auth.log | wc -l

##########################################
# 18. Firewall Rule Check
##########################################
iptables -L -n -v

##########################################
# 19. SSL Certificate Expiry Check
##########################################
openssl s_client -connect yourserver.com:443 </dev/null 2>/dev/null | openssl x509 -noout -dates

##########################################
# 20. HTTP URL Monitor Script
##########################################
URL="http://yourserver.com"
if curl -s --head $URL | grep "200 OK" > /dev/null; then
  echo "Site is UP"
else
  echo "Site is DOWN"
fi

# End of DevOps Shell Scripts Collection
