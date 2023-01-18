#!/bin/bash

clear

printf "Zadanie 3 \n"

for i in 1 2 3
do
  psql -U postgres -c "
    DROP USER IF EXISTS albrecht_$i;
    CREATE USER albrecht_$i WITH PASSWORD 'albrecht_$i';
    ALTER USER albrecht_$i WITH CREATEDB;
    DROP GROUP IF EXISTS albrecht$i;
    CREATE GROUP albrecht$i WITH LOGIN;
    ALTER GROUP albrecht$i ADD USER albrecht_$i;

  "
  psql -U postgres -c "\du+"

done

psql -U albrecht_1 -d postgres -c "DROP DATABASE IF EXISTS baza1;"
psql -U albrecht_1 -d postgres -c "CREATE DATABASE baza1 OWNER albrecht_1;"
psql -U albrecht_1 -d postgres -c "\l"

users=("" "albrecht_2" "albrecht_3" "albrecht_1")

for i in 1 2 3
do
  echo ${users[$i]};
  psql -U "albrecht_1" -d baza1 -c "
    CREATE SCHEMA IF NOT EXISTS schemat_$i;
    CREATE TABLE schemat_$i.tab (id text, w1 integer, w2 integer, w3 integer);
    GRANT SELECT (w1) ON schemat_$i.tab TO ${users[$i]};
    INSERT INTO schemat_$i.tab
      (id, w1, w2, w3)
    VALUES
      ('id1', 4, 14, 101),
      ('id1', 5, 15, 102),
      ('id1', 6, 16, 103);
    SELECT privilege_type FROM information_schema.table_privileges WHERE GRANTEE = 'albrecht_$i' AND table_name='tab';
  "
done

#psql -U postgres -d baza1 -c "
#  GRANT SELECT (w1) ON schemat_1.tab TO albrecht_2, albrecht_3;
#  GRANT SELECT (w1) ON schemat_2.tab TO albrecht_1, albrecht_3;
#  GRANT SELECT (w1) ON schemat_3.tab TO albrecht_1, albrecht_2;
#  SELECT * FROM information_schema.role_table_grants WHERE grantee = 'albrecht_1';
#  SELECT privilege_type FROM information_schema.table_privileges WHERE grantee = 'albrecht_2';
#  SELECT privilege_type FROM information_schema.table_privileges WHERE grantee = 'albrecht_3';
#"

