#!/bin/sh

echo "Waiting for MySQL"
until mysql -h 127.0.0.1 -P 3306 -uroot -p"magento2" -e "SHOW DATABASES;" &> /dev/null
do
  printf "."
  sleep 1
done
echo "\nMySQL ready"
