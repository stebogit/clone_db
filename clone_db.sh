#!/bin/bash
# Originally from: http://www.harecoded.com/copycloneduplicate-mysql-database-script-2184438
# by Albert Lombarte


#################
# This script allows you to create a local copy of a remote Database, provided 
# SSH user and host name of the remote server.
# Also, the user you use to connect to the local mysql instance needs CREATE and 
# DROP database permissions.
# 
# The script will do the following in order:
# 1. Delete the local COPY database if it exists
# 2. Create a local COPY database
# 3. Dump (i.e. copy) the REMOTE database
# 4. Inject the output of the dump into the COPY database
# Any errors during the process will be logged to the ERROR file
# 
# To lunch the script modify the credentials and run: bash ~/clone_db.sh
#################

# Set variables
SSH_USER=ssh_user
SSH_REMOTE_HOST=ssh_remotehost

REMOTE_DB=remoteDbName
COPY_DB=localDbName
USER=root
PASS="yourpassword"
ERROR=/clone_db_error.log

echo "Copying..."
ssh -C $SSH_USER@$SSH_REMOTE_HOST && mysql -u$USER -p$PASS -e "DROP DATABASE IF EXISTS `$COPY_DB`;" && mysql -u$USER -p$PASS -e "CREATE DATABASE `$COPY_DB`;" && mysqldump --force --log-error=$ERROR -u$USER -p$PASS $REMOTE_DB | ssh -C $SSH_USER@$SSH_REMOTE_HOST mysql -u$USER -p$PASS $COPY_DB
echo "Copy completed."

# End script