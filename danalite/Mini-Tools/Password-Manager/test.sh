#!/bin/bash

output=$(pass)
json='{"passwords":['

while read -r line
do
    count=$(echo "$line" | sed -E 's/^[^a-zA-Z]*(├|└)/_/g')
    echo "$count"
done <<< "$output"

