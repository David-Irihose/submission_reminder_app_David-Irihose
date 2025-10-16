#!/bin/bash
echo "Starting Submission Reminder App..."

main_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$main_dir"

bash "$main_dir/app/reminder.sh"