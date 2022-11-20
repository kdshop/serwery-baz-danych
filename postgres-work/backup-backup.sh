#!/bin/bash

clear

echo "--------------------------------------------"
printf "Wykonana zaraz zostanie kopia zapasowa bazy do pliku dump! \n"
echo "--------------------------------------------"

echo "nazwa katalogu:"

read katalog

if [ -d "$katalog" ];
then
  echo "nazwa pliku:"

  read plik

  if [ -f "$katalog/$plik" ];
  then
    echo "Plik istnieje!"
  else
    pg_dumpall -U postgres > "$katalog/$plik.dump"

    printf "Kopia zapasowa wykonana! \n"

    ls -l "$katalog/$plik.dump"
  fi

else
  echo "Katalog nie istnieje!"
fi