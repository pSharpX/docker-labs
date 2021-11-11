#!/bin/sh
#echo Building psharpx/graphbook-api:v1.0
echo Building psharpx/graphbook-client:v1.0

#docker build --no-cache -t psharpx/graphbook-api:v1.0 . -f Dockerfile
docker build --no-cache -t psharpx/graphbook-client:v1.0 . -f Dockerfile.client

echo Building was successful !!...

read -n 1 -s -r -p "Press any key to continue"