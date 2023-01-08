#!/bin/bash

clear

ls backup

psql -U postgres -c 'DROP DATABASE IF EXISTS french;'

printf "Baza danych french została usunięta, przywracanie danych z pliku dump."

printf "Proszę o podanie scieżki pliku z którego ma zostać odzyskana baza danych:"

read -r baza

if [ -f "backup/$baza" ]
then
  psql -U postgres -c 'CREATE DATABASE french'
  psql -U postgres -d french < "backup/$baza"
else
  printf "Plik o podanej nazwie nie istnieje"
fi
