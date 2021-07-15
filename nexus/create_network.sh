#!/bin/sh

network_name=devops/development
# Checking network status
echo "Checking network status for container.."

if [[ "$(docker network ls -q -f name=$network_name 2> /dev/null)" == "" ]]; then
  # do something
  echo "Docker network $network_name does not exist.."
  read -p "Enter a docker network name [$network_name]: " input_network_name
  network_name=${input_network_name:-$network_name}
  docker network create $network_name
  echo "Docker network created successfully !"
else
  echo "Docker network [$network_name] already exist..!"
fi

read -n 1 -s -r -p "Press any key to continue"