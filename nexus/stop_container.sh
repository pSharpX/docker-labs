#!/bin/sh
container_name=devops_nexus

# Checking docker container status
echo "Checking docker container status.."

read -p "Enter your docker container name [$container_name]: " input_container_name
container_name=${input_container_name:-$container_name}

if [[ "$(docker container ls -a -q -f name=$container_name 2> /dev/null)" != "" ]]; then
  # do something
  if [[ "$(docker container ls -a -q -f name=$container_name -f status=running 2> /dev/null)" != "" ]]; then
	echo "Stopping docker container $container_name..!"
	docker container stop $container_name
  else
	echo "Docker container is not running..!"
  fi
else
  echo "Docker container [$container_name] does not exist.."
fi
