#!/bin/bash
#
# /opt/git/marsender/directus-project/cmd/backup_db.sh
#
# Backup command:
#   mariadb-dump -udirectus '-pChangeMe' --comments=false directus-project > /opt/git/marsender/directus-project/cmd/directus-project.sql
# Dump no data (table structure)
#   mariadb-dump -udirectus '-pChangeMe' --no-data directus-project > /opt/git/marsender/directus-project/cmd/directus-project_nodata.sql
#
# Restore command:
#   git -C /opt/git/marsender/directus-project pull
#   mariadb -udirectus '-pChangeMe' directus-project < /opt/git/marsender/directus-project/cmd/directus-project.sql
#

source "$HOME/.bashrc"

#/usr/bin/git -C /opt/git/marsender/directus-project pull

db_password_file=.env_db_password
if [ ! -f $db_password_file ]; then
	echo 'Missing password file' $db_password_file
	exit 0
fi

db_name=directus-project
backup_path=/opt/git/marsender/directus-project/cmd
db_password=`cat $db_password_file`

options="--order-by-primary=true --comments=false --ignore-table=$db_name.doctrine_migration_versions --ignore-table=$db_name.messenger_messages"
/usr/bin/mariadb-dump -udirectus "-p${db_password}" $options $db_name > $backup_path/$db_name.sql

#/usr/bin/git -C /opt/git/marsender/directus-project commit -m "Backup $db_name" $backup_path
#/usr/bin/git -C /opt/git/marsender/directus-project push

exit 0
