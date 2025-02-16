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

# Get current path and parent path
backup_path=$(dirname "$0")
project_path=$(dirname "$backup_path")

#/usr/bin/git -C /opt/git/marsender/directus-project pull

cd $project_path
db_database_file=.env_db_database
if [ ! -f $db_database_file ]; then
	echo 'Missing db database file' $db_database_file
	exit 0
fi
db_user_file=.env_db_user
if [ ! -f $db_user_file ]; then
	echo 'Missing db user file' $db_user_file
	exit 0
fi
db_password_file=.env_db_password
if [ ! -f $db_password_file ]; then
	echo 'Missing db password file' $db_password_file
	exit 0
fi

#/opt/git/marsender/directus-project/cmd
db_database=`cat $db_database_file`
db_user=`cat $db_user_file`
db_password=`cat $db_password_file`

echo "*** Backup database $db_database ***"
options="--order-by-primary=true --comments=false"
/usr/bin/mariadb-dump -u${db_user} "-p${db_password}" $options $db_database > $backup_path/$db_database.sql

#/usr/bin/git -C /opt/git/marsender/directus-project commit -m "Backup $db_database" $backup_path
#/usr/bin/git -C /opt/git/marsender/directus-project push

exit 0
