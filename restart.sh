#!/bin/bash

clear
docker stop postgres
rm -rf ./postgres-data
ls ./postgres-data
docker-compose up -d