#!/bin/bash

clear

printf "Zadanie 30 \n"

for i in 1 2 3
do
  psql -U postgres -c "
    CREATE USER user$i;
    ALTER USER user$i WITH PASSWORD 'user$i';
    ALTER ROLE user$i WITH CREATEDB;
  "
  psql -U "user$i" -d postgres -c "
    CREATE DATABASE bd$i;
  "
  psql -U "user$i" -d "bd$i" -c "
    CREATE SCHEMA sch$i;
    CREATE TABLE sch$i.t$i (\"user\" text, database text);
    INSERT INTO sch$i.t$i
      (\"user\", database)
    VALUES
      ('user1','bd1'),
      ('user2','bd2'),
      ('user3','bd3');
  "
done
