#!/bin/bash

docker exec -t postgres chmod 777 ./home/Ad"$1".sh
docker exec -t postgres ./home/Ad"$1".sh