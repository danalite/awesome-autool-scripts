#!/bin/bash

IFS=$'\n'
json_array=()

first=true
while read line; do
    count=$(echo "$line" | awk '{ match($0, /^[^a-zA-Z]+/); print RLENGTH }')
    trimmed=$(echo "$line" | sed -E "s/^[^a-zA-Z]+//")
    if [[ "$line" =~ ^[├└]──\  ]]; then
        category=$(echo "$trimmed" | sed 's/ /_/g')
        # patch: remove the first character from the category
        category=${category:1}
        
    elif [[ ! "$line" =~ ^Password ]]; then
        password=$(echo "$trimmed" | sed 's/ /_/g')
        if [[ "$first" = true ]]; then
            first=false
        else
            json_array+=(",")
        fi
        json_array+=("'$category/$password'")
    fi
done <<< "$(pass)"

# remove color codes
echo "[ ${json_array[*]} ]" | tr -d '\n' | sed -E 's/\x1B\[[0-9;]*[JKmsu]//g'
