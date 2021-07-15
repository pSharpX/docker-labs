#!/bin/sh
echo Building cibertec/mongo_emisionvotos:1.0-stack

docker build --no-cache -t cibertec/mongo_emisionvotos:1.0-stack . -f Dockerfile.mongo

echo Building was successful !!...
read -n 1 -s -r -p "Press any key to continue"
