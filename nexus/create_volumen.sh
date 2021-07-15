#!/bin/sh
volume_name=nexus-data

# Checking volume status
echo "Checking volume status for container.."

if [[ "$(docker volume ls -q -f name=$volume_name 2> /dev/null)" == "" ]]; then
  # do something
  echo "Docker volume $volume_name does not exist.."
  read -p "Enter a docker volume name [$volume_name]: " input_volume_name
  volume_name=${input_volume_name:-$volume_name}
  docker volume create $volume_name
  echo "Docker volume created successfully..!"
else
  echo "Docker volume [$volume_name] already exist..!"
fi

read -n 1 -s -r -p "Press any key to continue"