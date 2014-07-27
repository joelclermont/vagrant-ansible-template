#!/bin/bash
if [ "$#" == "0" ]; then
  TYPE=constant
else
  TYPE=$1
fi

BACKUPFILE=full-$TYPE-file-backup-$(date -d "today" +"%Y-%m-%d-%H%M")

cd ~/
tar cvzf $BACKUPFILE.tgz /vagrant

s3cmd put $BACKUPFILE.tgz s3://**bucket_name**/$BACKUPFILE.tgz
# scp $BACKUPFILE.tgz **remote_user**@**remote_host**:/backup
rm $BACKUPFILE.tgz