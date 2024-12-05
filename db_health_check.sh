#!/bin/bash

# Database connection parameters
DB_HOST=$1
DB_USER=$2
DB_PASSWORD=$3
DB_NAME=$4

# Check if all required parameters are provided
if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ] || [ -z "$DB_NAME" ]; then
  echo "Usage: $0 <DB_HOST> <DB_USER> <DB_PASSWORD> <DB_NAME>"
  exit 1
fi

# Try to connect to the database and check the connection status
mysql --host="$DB_HOST" --user="$DB_USER" --password="$DB_PASSWORD" --database="$DB_NAME" -e "SELECT 1;" > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Database connection successful"
  exit 0
else
  echo "Failed to connect to the database"
  exit 1
fi