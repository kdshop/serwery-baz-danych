#!/bin/bash

clear

echo "--------------------------------------------"
printf "Wykonywanie kopii zapasowej bazy danych! \n"
echo "--------------------------------------------"

mkdir backup_french
ls -ld backup_french
printf "Katalog do kopii zapasowej został utworzony! \n"

chmod a+rwx ./backup_french

pg_dumpall -U postgres > ./backup_french/backup.dump

printf "Kopia zapasowa wykonana! \n"

ls -l ./backup_french/backup.dump

rm -rf backup_french