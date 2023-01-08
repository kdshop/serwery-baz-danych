#!/bin/bash

clear

if [ -d "./backup" ]
then
  if [ -f "licznik.tmp" ]
  then
    licznik=$(cat "licznik.tmp")
    licznik=$((licznik+1))
    echo $licznik>licznik.tmp
    echo $licznik

    if [ $((licznik % 5)) != "0" ]
    then
      pg_dump -U postgres -d french -f "./backup/kopia$((licznik % 5)).dump"
    else
      rm -rf backup/*.*
      pg_dump -U postgres -d french -f "./backup/kopia$((licznik / 5)).dump"
    fi
  else
    licznik=0
    licznik=$((licznik+1))
    echo $licznik>licznik.tmp
    pg_dump -U postgres -d french -f "./backup/kopia1.dump"
  fi
else
  mkdir backup
fi