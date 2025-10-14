#!/bin/bash

# Prompt user for the new assignment name
echo -n "Enter the new assignment name: "
read new_assignment

# Define the path to the config file
config_file="./config/config.env"

# Check if config file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file not found at $config_file"
    exit 1
fi

# Update the ASSIGNMENT value using sed
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_file"

echo "Assignment name updated to '$new_assignment' in $config_file"
echo "---------------------------------------------"

# Re-run the startup.sh script to check submissions for the new assignment
echo "Running the startup script for updated assignment..."
bash ./startup.sh
