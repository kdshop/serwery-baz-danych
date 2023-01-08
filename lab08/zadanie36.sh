#!/bin/bash

clear

echo "Zadanie 36"
if [ -d "./backup_abc" ]
then
  echo
else
  mkdir backup_abc
fi


for i in 1
do
  echo "Zaraz zostanie wykonana kopia zapasowa bazy danych abc$i do katalogu /backup_abc"
  pg_dump -U "abc$i" -d "abc$i" -f "./backup_abc/kopia_abc$i.sql"
  pg_dump -Fc -U "abc$i" -d "abc$i" -f "./backup_abc/kopia_abc$i.dump"
  echo "Kopia zapasowa abc$i wykonana!"
  ls -l "./backup_abc/kopia_abc$i.sql"
  ls -l "./backup_abc/kopia_abc$i.dump"
done

rm -rf backup_abc