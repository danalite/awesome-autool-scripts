#!/bin/bash

# Run todo.sh and store the output in a variable
output=$(todo.sh -d ./configs/tasks.cfg ls)

# Initialize an empty array for the tasks
tasks=()

# Loop over each line in the output
first=true
while read -r line; do
  # Check if the line starts with a number (i.e. a task ID)
  if [[ "$line" =~ ^[0-9]+ ]]; then
    # Extract the task ID and description
    id=$(echo "$line" | cut -d " " -f 1)
    description=$(echo "$line" | cut -d " " -f 2-)

    # Append the task to the array
    if [ "$first" = true ]; then
      tasks+=("'$description'")
      first=false
    else
      tasks+=(", '$description'")
    fi
  fi
done <<< "$output"

# Generate the JSON output
json="[${tasks[@]}]"

# Save the JSON to a file
echo "$json"