#!/bin/sh
echo Building cibertec/javaclient_emisionvotos:1.0-stack

docker build --no-cache -t cibertec/javaclient_emisionvotos:1.0-stack . -f Dockerfile.client

echo Building was successful !!...

read -n 1 -s -r -p "Press any key to continue"
