#!/bin/bash

# Prompt user for the new assignment name
echo -n "Enter the new assignment name: "
read new_assignment

main_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the path to the config file
config_file="$(find "$main_dir" -type f -path "*/config/config.env" | head -n 1)"
startup_file="$(find "$main_dir" -type f -name "startup.sh" | head -n 1)"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file not found at $config_file"
    exit 1
fi

# Update the ASSIGNMENT value in config.env
sed -i "" "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_file"

echo "Assignment updated to '$new_assignment' in config.env."

#Display the updated config for confirmation
cat "$config_file"
echo "Running the startup script."
bash "$startup_file" 
