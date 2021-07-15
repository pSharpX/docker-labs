#!/bin/sh
echo "testing bash !!"

name="this is my name"
surname="this is my surname"
country="this is my country"

read -p "Enter your name: " input_name
if [[ -n "$input_name" ]];
then
	name=$input_name
fi
echo "Hello $name !!..."

exit;

echo "testing bash 2 !!"
read -p "Enter your surname: " input_surname
##surname=$(( test -n "$input_surname" ? $input_surname:$surname))
surname=$([ "$input_surname" ] && echo "$input_surname" || echo "$surname")
echo "Hello $surname !!..."

echo "testing bash 3 !!"
read -p "Enter your country [$country]: " input_country
country=${input_country:-$country}
echo $country

read -n 1 -s -r -p "Press any key to continue"
