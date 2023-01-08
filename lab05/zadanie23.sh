#!/bin/bash

clear

tablica=(kopia1.dump kopia2.dump kopia3.dump kopia4.dump kopia5.dump)

if [ -d "./backup" ]
then
  if [ -f "licznik.tmp" ]
  then
    licznik=$(cat "licznik.tmp")
    licznik=$((licznik+1))
    echo $licznik>licznik.tmp
    echo $licznik

    if [ $((licznik % 5)) == "0" ]
    then
      rm -rf backup/*.*
    fi

    pg_dump -U postgres -d french -f "./backup/${tablica[$((licznik % 5))]}"

    ls backup
  else
    licznik=0
    licznik=$((licznik+1))
    echo $licznik>licznik.tmp
    pg_dump -U postgres -d french -f "kopia1.dump"
  fi
else
  mkdir backup
fi