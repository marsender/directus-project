#!/bin/bash

source "$HOME/.bashrc"

# Get current path and parent path
backup_path=$(dirname "$0")
project_path=$(dirname "$backup_path")

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

db_database=`cat $db_database_file`
db_user=`cat $db_user_file`
db_password=`cat $db_password_file`

echo "*** Backup database $db_database ***"
options="--order-by-primary=true --comments=false"
/usr/bin/mariadb-dump -u${db_user} "-p${db_password}" $options $db_database > $backup_path/$db_database.sql

exit 0
