#!/bin/sh
echo Validarion docker-compose configuration

# Workaround note: This is only use for docker compose versions under v1.28 becouse --env-file is not supported.
#eval source <(grep = .env.production)
#source ./.env.production

# Workaround note: This is only use for docker compose versions under v1.28 becouse --env-file is not supported.
# Use default name for env file to work: env
#docker-compose --env-file ./.env.production config 
#docker-compose config

# Deploy stack
docker-compose --env-file ./.env.production up

echo Configuration was successful !!...

read -n 1 -s -r -p "Press any key to continue"