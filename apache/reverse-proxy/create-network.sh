#!bin/sh

# Declaring vars
network_container_name=reverse-proxy-network
exist=0

error_message()
{
    echo "$1"
    exit
}

validate_input()
{
    # Input from user
    read -p "$1" input_network_container_name
    network_container_name=${input_network_container_name:-$network_container_name}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$network_container_name" =~ [^a-zA-Z0-9_-] || -z "$network_container_name" ]]
    do
        echo "The input contains special characters."
        echo "Input only alphanumeric characters."
        
        # Input from user
        read -p "$1" input_network_container_name
        network_container_name=${input_network_container_name:-$network_container_name}
        
        #loop until the user enters only alphanumeric characters.
    done
}

echo '==============> Creating Docker network for containers'

validate_input "1. Enter network name: [$network_container_name]: "

echo '2. Validating network:'
for i in $(docker network list --format '{{.Name}}')
do
    if [ $network_container_name = $i ]; then
        exist=1
    fi
done

if [ $exist = 1 ]; then
    error_message "Network already exist !!"
fi

echo "3. Creating network -> $network_container_name:"
docker network create $network_container_name

echo "4. Done"
echo "5. Listing all networks"
docker network ls --format "{{.Name}}"

read -n 1 -s -r -p "Press any key to continue.."