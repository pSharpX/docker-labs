#!/bin/sh
echo Building cibertec/wildfly_emisionvotos:1.0-stack

docker build --no-cache -t cibertec/wildfly_emisionvotos:1.0-stack . -f Dockerfile.web

echo Building was successful !!...
read -n 1 -s -r -p "Press any key to continue"
