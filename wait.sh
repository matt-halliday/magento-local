#!/bin/sh


CHECK_DB='mysql -h 127.0.0.1 -P 3306 -uroot -p"magento2" -e "SHOW DATABASES;"'
COUNTER=0
echo "Waiting for MySQL"
until eval $CHECK_DB &> /dev/null
do
  printf "."
  sleep 1
  ((COUNTER++))
  if [[ $COUNTER -eq 30 ]]; then
    echo "\nMySQL did not start:"
    eval $CHECK_DB
    exit 1
  fi
done

echo "\nMySQL ready"
