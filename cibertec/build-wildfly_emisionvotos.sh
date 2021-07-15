#!/bin/sh
echo Building cibertec/wildfly_emisionvotos:1.0-stack

docker build --no-cache -t cibertec/wildfly_emisionvotos:1.0-stack . -f Dockerfile

echo Building was successful !!...
