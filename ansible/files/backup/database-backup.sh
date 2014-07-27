#!/bin/bash
if [ "$#" == "0" ]; then
  TYPE=constant
else
  TYPE=$1
fi

BACKUPFILE=full-$TYPE-backup-$(date -d "today" +"%Y-%m-%d-%H%M").sql

mysqldump -u root --password="{{ mysql_root_pass }}" --single-transaction --databases {{ mysql_db_name }} > ~/$BACKUPFILE

mysqladmin -u root --password="{{ mysql_root_pass }}" flush-logs

cd ~/
tar cvzf $BACKUPFILE.tgz $BACKUPFILE
rm $BACKUPFILE

s3cmd put $BACKUPFILE.tgz s3://**bucket_name**/$BACKUPFILE.tgz
# scp $BACKUPFILE.tgz root@107.170.203.167:/backup
rm $BACKUPFILE.tgz