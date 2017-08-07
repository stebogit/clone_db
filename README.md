# clone_db

This bash script allows you to clone a remote (production?) database to a local (development?) copy.
The script assumes there is no password required tp SSH the remote server.
Also, the user you use to connect to the local mysql instance needs CREATE and DROP database permissions.

The script will do the following in order:
  1. Delete the local `COPY` database, if it exists
  2. Create a local `COPY` database
  3. Dump (i.e. copy) the `REMOTE` database
  4. Inject the output of the dump into the `COPY` database
Any errors during the process will be logged to a local .log file

### Usage
To lunch the script modify variables and credentials and run: 
```sh
bash ~/clone_db.sh
```
