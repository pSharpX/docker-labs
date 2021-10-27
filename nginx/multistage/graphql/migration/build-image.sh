#!/bin/sh
echo Building psharpx/graphbook-migration:1.0

docker build --no-cache -t psharpx/graphbook-migration:1.0 . -f Dockerfile

echo Building was successful !!...

read -n 1 -s -r -p "Press any key to continue"