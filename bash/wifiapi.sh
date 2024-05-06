#!/bin/bash

echo "Starting server for IP $DIVOOM_ADDRESS..."

docker-compose -f $DIVOOM/wifi/docker-compose.yml up -d

echo "Server started."

sleep 1

curl -X 'POST' \
	'http://localhost:5000/fill' \
	-H 'accept: application/json' \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-d 'r=1&g=1&b=1&push_immediately=true'

echo "Screen reseted."

curl -X 'POST' \
	'http://localhost:5000/image' \
	-H 'accept: application/json' \
	-H 'Content-Type: multipart/form-data' \
	-F "image=@$DIVOOM/icons/$DIVOOM_ICON;type=image/png" \
	-F 'x=0' \
	-F 'y=0' \
	-F 'push_immediately=true'

echo "Icon sent."

echo "Stopping server..."
docker-compose -f $DIVOOM/wifi/docker-compose.yml down
echo "Server stopped."
