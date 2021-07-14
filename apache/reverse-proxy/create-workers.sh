#!bin/sh

# Declaring vars
network_name=apache-reverse-proxy
image_name=worker-httpd

container_name=worker
container_number=4
container_metadata="artifact.group=apache-reverse-proxy"
exist=0

global_alphanumeric_input=N
global_numeric_input=0

error_message()
{
    echo "$1"
    exit
}

validate_container_name()
{
    # Input from user
    read -p "$1" input_container_name
    container_name=${input_container_name:-$container_name}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$container_name" =~ [^a-zA-Z0-9_-] || -z "$container_name" ]]
    do
        echo "The input contains special characters."
        echo "Input only alphanumeric characters."
        
        # Input from user
        read -p "$1" input_container_name
        container_name=${input_container_name:-$container_name}
        
        #loop until the user enters only alphanumeric characters.
    done
}

validate_input()
{
    # Input from user
    read -p "$1" input_value
    global_alphanumeric_input=${input_value:-$global_alphanumeric_input}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$global_alphanumeric_input" =~ [^a-zA-Z0-9_-] || -z "$global_alphanumeric_input" ]]
    do
        echo "The input contains special characters."
        echo "Input only alphanumeric characters."
        
        # Input from user
        read -p "$1" input_value
        global_alphanumeric_input=${input_value:-$global_alphanumeric_input}
        
        #loop until the user enters only alphanumeric characters.
    done
}

validate_containers_number()
{
    # Input from user
    read -p "$1" input_container_number
    container_number=${input_container_number:-$container_number}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$container_number" =~ [^0-9] || -z "$container_number" ]]
    do
        echo "The input contains words or special characters."
        echo "Input only numeric characters."
        
        # Input from user
        read -p "$1" input_container_number
        container_number=${input_container_number:-$container_number}
        
        #loop until the user enters only alphanumeric characters.
    done
}

validate_number()
{
    allow_empty_values=$2
    if [[ $allow_empty_values != 1 ]]; then
        allow_empty_values=0
    fi


    # Input from user
    read -p "$1" input_value
    initial_value=$global_numeric_input
    global_numeric_input=${input_value:-$global_numeric_input}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ ($allow_empty_values == 1 && $global_numeric_input =~ [^0-9]) || ($allow_empty_values != 1 && ($global_numeric_input =~ [^0-9] || -z $global_numeric_input)) ]]
    do
        echo "The input contains words or special characters."
        echo "Input only numeric characters."
        global_numeric_input=$initial_value
        
        # Input from user
        read -p "$1" input_value
        global_numeric_input=${input_value:-$global_numeric_input}
        
        #loop until the user enters only alphanumeric characters.
    done
}

left_pad_number()
{
    printf "%0$2d\n" $1
}

create_worker_containers()
{
    allow_empty_values=1

    for ((n=0;n<$2;n++))
    do
        docker_command="docker container create"

        current_container_name="$1_$(left_pad_number $n 3)"
        echo $current_container_name

        global_alphanumeric_input=$current_container_name
        validate_input "______a. Enter container name [$current_container_name]: "
        current_container_name=$global_alphanumeric_input

        global_alphanumeric_input=$network_name
        validate_input "______b. Enter network name [$network_name]: "
        network_name=$global_alphanumeric_input

        global_alphanumeric_input=$image_name
        validate_input "______c. Enter image name [$image_name]: "
        image_name=$global_alphanumeric_input

        publishing_port=""
        global_numeric_input=$publishing_port
        validate_number "______d. Enter publishing port (Forwarding): " $allow_empty_values
        publishing_port=$global_numeric_input

        if [[ -n "$publishing_port" && "$publishing_port" =~ ^[[:digit:]]+$  ]]; then
            docker_command="$docker_command -p $publishing_port:80"
        fi


        docker_command="$docker_command --label $container_metadata --network $network_name --name $current_container_name $image_name"
        echo "$($docker_command)"
    done
}


echo '==============> Creating Docker containers -> workers'
echo 'Note: Write [N/n] for entering no options'

validate_container_name "1. Enter container name: [$container_name]: "

echo '2. Validating container:'
for i in $(docker container ls -a --format '{{.Names}}')
do
    if [ $container_name = $i ]; then
        exist=1
    fi
done

if [ $exist = 1 ]; then
    error_message "Container already exist !!"
fi

validate_containers_number "3. Enter number of container/workers to be created: [$container_number]: "

echo "4. Creating worker container(s) -> $container_name:"
create_worker_containers $container_name $container_number


echo "5. Done"
echo "6. Listing all containers created"
docker container ls -a --format "{{.Names}}" | grep ^$container_name

read -n 1 -s -r -p "Press any key to continue.."