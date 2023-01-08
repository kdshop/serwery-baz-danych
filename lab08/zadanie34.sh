#!/bin/bash

clear

printf "Zadanie 34 \n"

for i in 1 2
do
  psql -U postgres -c "
    CREATE USER abc$i;
    ALTER USER abc$i WITH PASSWORD 'abc$i';
    ALTER ROLE abc$i WITH CREATEDB;
  "
  psql -U "abc$i" -d postgres -c "
    CREATE DATABASE abc$i;
  "
  psql -U "abc$i" -d "abc$i" -c "
    CREATE SCHEMA abc$i;
    CREATE TABLE abc$i.abc$i (lp integer, nazwisko text, wiek integer);
    INSERT INTO abc$i.abc$i
      (lp, nazwisko, wiek)
    VALUES
      (1, 'Kowalski', 22),
      (2, 'Nowak', 26),
      (3, 'Nowicka', 32);
  "
done

psql -U abc1 -d abc1 -c "
  GRANT USAGE ON SCHEMA abc1 TO abc2;
"

psql -U abc2 -d abc2 -c "
  GRANT USAGE ON SCHEMA abc2 TO abc1;
"