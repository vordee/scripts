#!/bin/bash
# Location to place backups.
backup_dir="/home/postgres-backup/"

#String to append to the name of the backup files
backup_date=`date +%d-%m-%Y`

#Numbers of days you want to keep copie of your databases
number_of_days=30

databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`

for i in $databases; do
  if [ "$i" != "template0" ] && [ "$i" != "template1" ]; then
    echo Dumping $i to $backup_dir$i\_$backup_date
    /usr/bin/pg_dump -Fc $i > $backup_dir$i\_$backup_date
  fi
done

#find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {}
