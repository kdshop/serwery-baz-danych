#!/bin/bash

clear

printf "Zadanie 1 i 2 \n"

for i in 1 2 3
do
  psql -U postgres -c "
    DROP USER IF EXISTS albrecht_$i;
    CREATE USER albrecht_$i WITH PASSWORD 'albrecht_$i';
    DROP GROUP IF EXISTS albrecht$i;
    CREATE GROUP albrecht$i WITH LOGIN CREATEDB;
    ALTER GROUP albrecht$i ADD USER albrecht_$i;
  "
  psql -U postgres -c "\du"

done

psql -U postgres -c "DROP DATABASE IF EXISTS baza1;"
psql -U postgres -c "CREATE DATABASE baza1 OWNER albrecht_1;"
psql -U postgres -c "\l"

for i in 1 2 3
do
  psql -U postgres -d baza1 -c "
    CREATE SCHEMA IF NOT EXISTS schemat_$i AUTHORIZATION albrecht_$i;;
    CREATE TABLE schemat_$i.tab (id text, w1 integer, w2 integer, w3 integer);
    INSERT INTO schemat_$i.tab
      (id, w1, w2, w3)
    VALUES
      ('id1', 4, 14, 101),
      ('id1', 5, 15, 102),
      ('id1', 6, 16, 103);
  "
done

psql -U postgres -c "DROP DATABASE IF EXISTS baza1;"

for i in 1 2 3
do
  psql -U postgres -c "
    DROP GROUP IF EXISTS albrecht$i;
    DROP USER IF EXISTS albrecht_$i;
  "
done