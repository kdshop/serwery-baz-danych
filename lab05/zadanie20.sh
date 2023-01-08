#!/bin/bash

clear

printf "Przywracanie bazy franch! \n"

psql -U postgres -c 'DROP DATABASE IF EXISTS french;'

psql -U postgres -c 'CREATE DATABASE french'

psql -U postgres -d french < french-towns-communes-francaises.sql