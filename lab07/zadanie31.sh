#!/bin/bash

clear

printf "Zadanie 30 \n"

psql -U user1 -d bd1 -c "
  RANT USAGE ON SCHEMA sch2 TO user2, user3;
"

psql -U user2 -d bd2 -c "
  RANT USAGE ON SCHEMA sch2 TO user1, user3;
"

psql -U user3 -d bd3 -c "
  RANT USAGE ON SCHEMA sch2 TO user1, user2;
"