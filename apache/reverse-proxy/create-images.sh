#!bin/sh

# Declaring vars
image_name=master-httpd
image_number=1
image_metadata="artifact.group=apache-reverse-proxy"

global_alphanumeric_input=N
global_numeric_input=0
exist=0

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

left_pad_number()
{
    printf "%0$2d\n" $1
}

create_images()
{
    for ((n=0;n<$2;n++))
    do
        dockerfile_path="./worker"
        dockerfile_name="worker/Dockerfile"
        current_image_name="$1_$(left_pad_number $n 3)"
        echo $current_image_name

        global_alphanumeric_input=$current_image_name
        validate_input "______a. Enter image name [$current_image_name]: "
        current_image_name=$global_alphanumeric_input

        global_alphanumeric_input=$dockerfile_name
        validate_input "______c. Enter dockerfile name [$dockerfile_name]: "
        dockerfile_name=$global_alphanumeric_input

        global_alphanumeric_input=$dockerfile_path
        validate_input "______c. Enter dockerfile PATH/URL [$dockerfile_path]: "
        dockerfile_path=$global_alphanumeric_input

        global_alphanumeric_input=$image_metadata
        validate_input "______d. Enter image labels [$image_metadata]: "
        image_metadata=$global_alphanumeric_input

        docker image build --no-cache -t $image_name --label $image_metadata -f $dockerfile_name $dockerfile_path
    done
}

echo '==============> Creating Docker images -> master/workers'

global_alphanumeric_input=$image_name
validate_input "1. Enter images name: [$image_name]: "
image_name=$global_alphanumeric_input

echo '2. Validating image:'
for i in $(docker image ls -a --format '{{.Repository}}')
do
    if [ $image_name = $i ]; then
        exist=1
    fi
done

if [ $exist = 1 ]; then
    error_message "Image already exist !!"
fi

global_numeric_input=$image_number
validate_number "3. Enter number of images to be created: [$image_number]: "
image_number=$global_numeric_input

echo "4. Creating master/worker image(s) -> $image_name:"
create_images $image_name $image_number


echo "5. Done"
echo "6. Listing all images created"
docker image ls -a --format "{{.Repository}}" | grep ^$image_name

read -n 1 -s -r -p "Press any key to continue.."