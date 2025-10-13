#!/bin/bash

# Prompt user for their name
echo "Enter your name:"
read username

# Create main directory
main_dir="submission_reminder_${username}"
mkdir -p $main_dir

echo "✅ Directory '$main_dir' created."

# Create subdirectories
mkdir -p $main_dir/config
mkdir -p $main_dir/scripts
mkdir -p $main_dir/data
mkdir -p $main_dir/assets

echo "✅ Subdirectories created (config, scripts, data, assets)."

# Create image placeholder
touch $main_dir/assets/image.png

# Create submissions.txt with extra records
cat > $main_dir/data/submissions.txt <<EOL
Name,Assignment,Status
Alice,Assignment1,Submitted
Bob,Assignment1,Pending
Clara,Assignment1,Submitted
David,Assignment1,Pending
Eve,Assignment1,Submitted
Frank,Assignment1,Pending
Grace,Assignment1,Submitted
Helen,Assignment1,Pending
Ian,Assignment1,Submitted
Jane,Assignment1,Pending
EOL

echo "✅ submissions.txt created with 10 student records."

# Create config.env
cat > $main_dir/config/config.env <<EOL
# Configuration for Reminder App
ASSIGNMENT="Assignment1"
REMINDER_MESSAGE="You have not submitted your assignment yet!"
EOL

echo "✅ config.env created."

# Create functions.sh
cat > $main_dir/scripts/functions.sh <<'EOL'
#!/bin/bash
show_pending_students() {
  echo "🔍 Checking for pending submissions..."
  grep "Pending" ../data/submissions.txt | cut -d',' -f1
}
EOL

echo "✅ functions.sh created."

# Create reminder.sh
cat > $main_dir/scripts/reminder.sh <<'EOL'
#!/bin/bash
source ./functions.sh
source ../config/config.env

echo "📢 Reminder for $ASSIGNMENT:"
pending_students=$(show_pending_students)

if [ -z "$pending_students" ]; then
  echo "🎉 All students have submitted!"
else
  echo "⚠️ Students to remind:"
  echo "$pending_students"
  echo "$REMINDER_MESSAGE"
fi
EOL

echo "✅ reminder.sh created."

# Create startup.sh
cat > $main_dir/scripts/startup.sh <<'EOL'
#!/bin/bash
echo "🚀 Starting Submission Reminder App..."
bash ./reminder.sh
EOL

echo "✅ startup.sh created."

# Make all .sh scripts executable
chmod +x $main_dir/scripts/*.sh

echo "🎯 All scripts made executable."
echo "✅ Environment setup complete!"
echo "Run the app by navigating to: cd $main_dir/scripts"
echo "Then type: ./startup.sh"

