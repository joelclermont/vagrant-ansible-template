#!/bin/bash
if [ "$#" == "0" ]; then
  TYPE=constant
else
  TYPE=$1
fi

BACKUPFILE=full-$TYPE-backup-$(date -d "today" +"%Y-%m-%d-%H%M").sql

mysqldump -u root --password="{{ mysql_root_pass }}" --single-transaction --databases{% for db in mysql_db_names %} {{ db }}{% endfor %} > ~/$BACKUPFILE

mysqladmin -u root --password="{{ mysql_root_pass }}" flush-logs

cd ~/
tar cvzf $BACKUPFILE.tgz $BACKUPFILE
rm $BACKUPFILE

s3cmd put $BACKUPFILE.tgz s3://{{ s3_bucket_name }}/$BACKUPFILE.tgz
# scp $BACKUPFILE.tgz {{ scp_user }}@{{ scp_host }}:/backup
rm $BACKUPFILE.tgz
