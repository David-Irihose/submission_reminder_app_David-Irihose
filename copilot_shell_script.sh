#!/bin/bash

# Ask user for new assignment name
echo "Enter new assignment name (no spaces, use underscores):"
read new_assignment

# File paths
CONFIG_FILE="submission_reminder_Irihose/config/config.env"
TMP_FILE="submission_reminder_Irihose/config/config.tmp"

# Make sure the file is writable
chmod u+w $CONFIG_FILE

# Replace ASSIGNMENT line safely (macOS compatible)
awk -v new="$new_assignment" 'BEGIN{FS=OFS="="} /^ASSIGNMENT=/ 
{$2="\""new"\""} {print}' $CONFIG_FILE > $TMP_FILE
mv $TMP_FILE $CONFIG_FILE

echo "✅ Assignment name updated to: $new_assignment"

# Run the app
cd submission_reminder_Irihose/scripts
./startup.sh


