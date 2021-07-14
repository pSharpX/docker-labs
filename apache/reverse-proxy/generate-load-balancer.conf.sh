#!bin/sh

# Declaring vars
template_file="vhost-default.conf.tmpl"
container_metadata="artifact.group=apache-reverse-proxy"

global_alphanumeric_input=N
global_numeric_input=0
exist=0

BALANCER_MEMBERS="here balancer-members"

print_ip="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"
print_ip_and_port="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"

error_message()
{
    echo "$1"
    exit
}

validate_input()
{
    # Input from user
    read -p "$1" input_value
    global_alphanumeric_input=${input_value:-$global_alphanumeric_input}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$global_alphanumeric_input" =~ [^a-zA-Z0-9_-.] || -z "$global_alphanumeric_input" ]]
    do
        echo "The input contains special characters."
        echo "Input only alphanumeric characters."
        
        # Input from user
        read -p "$1" input_value
        global_alphanumeric_input=${input_value:-$global_alphanumeric_input}
        
        #loop until the user enters only alphanumeric characters.
    done
}

validate_number()
{
    # Input from user
    read -p "$1" input_value
    global_numeric_input=${input_value:-$global_numeric_input}

    # While loop for alphanumeric characters and a non-zero length input
    while [[ "$global_numeric_input" =~ [^0-9] || -z "$global_numeric_input" ]]
    do
        echo "The input contains words or special characters."
        echo "Input only numeric characters."
        
        # Input from user
        read -p "$1" input_value
        global_numeric_input=${input_value:-$global_numeric_input}
        
        #loop until the user enters only alphanumeric characters.
    done
}

search_containers_by_metadata()
{
    docker ps -q --filter "label=$1"
}

inspecting_containers()
{
    docker inspect $1 --format "$2"
}

render_template()
{
    eval "echo \"$(cat $1)\""
}

echo '==============> Search Docker containers -> workers'

global_alphanumeric_input=$container_metadata
validate_input "1. Enter container metadata: [$container_metadata]: "
container_metadata=$global_alphanumeric_input

echo '2. Listing containers:'
for i in $(search_containers_by_metadata $container_metadata)
do
    echo $i
done

echo '2. Inspecting containers IPs:'
containers=$(search_containers_by_metadata $container_metadata)

BALANCER_MEMBERS=""
for i in $(inspecting_containers "$containers" "$print_ip")
do
    echo $i
    #BalancerMember http://172.18.0.3:80
    #BALANCER_MEMBERS="$BALANCER_MEMBERS
    #BalancerMember http://$i:80"
done

#render_template $template_file > 'master/sites/vhost-default.conf'

read -n 1 -s -r -p "Press any key to continue.."