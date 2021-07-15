#!/bin/sh

# Declaring variables
container_name=devops_nexus
network_name=devops/development
volume_name=nexus-data
image_name=sonatype/nexus3:3.24.0

# Checking image status
echo "Checking if image [$image_name] exist..!"

if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then
  # do something
  echo "Docker images does not exist..!"
  read -p "Enter a nexus docker image [$image_name]: " input_image_name
  image_name=${input_image_name:-$image_name}
  if [[ "$(docker pull -q $image_name 2> /dev/null)" != "" ]]; then
	echo "Docker image pulled successfully..!"
  else
	echo "A problem ocurred while trying to pull image $image_name..!"
  fi
fi

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

# Checking docker container status
echo "Checking docker container status.."

if [[ "$(docker container ls -a -q -f name=$container_name 2> /dev/null)" == "" ]]; then
  # do something
  read -p "Enter a name for your docker container [$container_name]: " input_container_name
  container_name=${input_container_name:-$container_name}
  
  if [[ "$(docker container create -p 8081:8081 -v $volume_name:/nexus-data --network $network_name --name $container_name $image_name 2> /dev/null)" != "" ]]; then
	echo "ContainerId: $?"
	echo "Docker container created successfull..!"
  else
	echo "A problem ocurred while trying to create container [$container_name] - Response: $?"
  fi
else
  echo "Docker container [$container_name] already exist.."
fi

read -n 1 -s -r -p "Press any key to continue"
