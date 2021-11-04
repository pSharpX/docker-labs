#!/bin/sh
CONTAINER_NAME=seed-runner

echo Building $CONTAINER_NAME container.

docker run --rm --name $CONTAINER_NAME --network=graphql_graphbook/in.production --env-file .env psharpx/graphbook-seeder:1.0

#--network=graphbook/in.production
#--add-host=docker:93.184.216.34