#!/usr/bin/env bash
echo "Creating users..."
mongo votoelectronico_db --authenticationDatabase admin --host localhost -u admin -p \$admin123.a --eval "db.createUser({user: 'votoelectronico_user', pwd: '\$votoelectronico_user123.a',roles: [{role: 'readWrite', db: 'votoelectronico_db'}]}); db.createUser({user: 'votoelectronico_reporter', pwd: '\$votoelectronico_reporter123.a', roles: [{role: 'read', db: 'votoelectronico_db'}]});"
echo "Users created."