#!/bin/bash

clear

printf "Zadanie 35 \n"

psql -U postgres -c "
  CREATE ROLE wyswietlabc1 WITH LOGIN;
  CREATE ROLE wyswietlabc2 WITH LOGIN;
  CREATE ROLE wyswietlnazwiskoabc2 WITH LOGIN;
  CREATE ROLE wyswietlwiekabc1 WITH LOGIN;

  GRANT wyswietlabc1 to abc2, postgres;
  GRANT wyswietlabc2 to abc1, postgres;
  GRANT wyswietlnazwiskoabc2 to abc1;
  GRANT wyswietlwiekabc1 to abc2;
"

psql -U abc1 -d abc1 -c "
  GRANT SELECT (wiek) on abc1.abc1 to wyswietlwiekabc1;
  GRANT SELECT on abc1.abc1 to wyswietlabc1;
"

psql -U abc2 -d abc2 -c "
  GRANT SELECT (nazwisko) on abc2.abc2 to wyswietlnazwiskoabc2;
  GRANT SELECT on abc2.abc2 to wyswietlabc2;
"
