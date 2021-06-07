#!/bin/sh

CHECK_DB='nc -z db 3306'
COUNTER=0

echo "Waiting for MySQL"
until eval $CHECK_DB
do
  printf "."
  sleep 1
  if [[ $COUNTER -eq 30 ]]; then
    echo -e "\nMySQL did not start:"
    eval $CHECK_DB -v
    exit 1
  fi
  ((COUNTER++))
done

echo -e "\nMySQL ready"
