#!/bin/bash
if [ "$#" == "0" ]; then
  TYPE=constant
else
  TYPE=$1
fi

BACKUPFILE=full-$TYPE-file-backup-$(date -d "today" +"%Y-%m-%d-%H%M")

cd ~/
tar cvzf $BACKUPFILE.tgz /vagrant

s3cmd put $BACKUPFILE.tgz s3://{{ s3_bucket_name }}/$BACKUPFILE.tgz
# scp $BACKUPFILE.tgz {{ scp_user }}@{{ scp_host }}:/backup
rm $BACKUPFILE.tgz

# if you don't want to create a full snapshot of your whole site
# another nice approach is to selectively rsync specific folders
# up to S3. Especially nice for folders containing client generated
# content.

#s3cmd sync --recursive /var/www/code/**folder name** s3://{{ s3_bucket_name }}/client-files/