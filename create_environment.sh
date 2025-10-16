#!/bin/bash

# Prompt user for their name
echo -n "Enter your name: "
read username

# Create main directory
main_dir="submission_reminder_${username}"
mkdir -p $main_dir

echo "Directory '$main_dir' created."

# Create subdirectories
mkdir -p $main_dir/config
mkdir -p $main_dir/app
mkdir -p $main_dir/modules
mkdir -p $main_dir/assets

echo "Subdirectories created (config, scripts, data, assets)."

# Create submissions.txt with extra records
cat > $main_dir/assets/submissions.txt <<EOL
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Alice,Shell Basics,Submitted
Bob,Python,Pending
Clara, Shell Permissions,Submitted
David, Shell Signals,Pending
Eve, Shell proccess,Submitted
EOL

echo "submissions.txt created with 9 student records."

# Create config.env
cat > $main_dir/config/config.env <<EOL
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

echo "config.env created."

# Create functions.sh
cat > $main_dir/modules/functions.sh <<'EOL'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

echo "functions.sh created."

# Create reminder.sh
cat > $main_dir/app/reminder.sh <<'EOL'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOL

echo "reminder.sh created."

# Create startup.sh
cat > $main_dir/startup.sh <<'EOL'
#!/bin/bash
echo "Starting Submission Reminder App..."

main_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$main_dir"

bash "$main_dir/app/reminder.sh"
EOL

echo "startup.sh created."

# Make all .sh scripts executable
chmod +x $main_dir/app/*.sh
chmod +x $main_dir/modules/*.sh
chmod +x $main_dir/*.sh


echo "All scripts made executable."
echo "Environment setup complete!"
echo "Run the app by navigating to: cd $main_dir/scripts"
echo "Then type: ./startup.sh"

