#!bin/sh

input="212"

allow_empty_values=0
expression="-n $input && $input =~ ^[[:digit:]]+$"

if [[ $allow_empty_values = 1 ]]; then
    expression="-n $input"
fi

if [[ ($allow_empty_values == 1 && -n $input) || ($allow_empty_values != 1 && -n $input && $input =~ ^[[:digit:]]+$) ]]; then
    echo "success !!"
fi

echo "done !!"