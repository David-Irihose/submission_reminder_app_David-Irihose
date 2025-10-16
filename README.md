# submission_reminder_app_irihose

## Overview
This app checks which students have not submitted their assignment.  
It uses simple shell scripts, organized into folders automatically by 
`create_environment.sh`.

## How to run
1. Make sure your scripts are executable:
```bash
chmod +x create_environment.sh copilot_shell_script.sh
```
2. Then run create_environment.sh to create specific environment
```bash
./create_environment.sh
```
3. Then run startup.sh to run application
```bash
cd submission_reminder_{your_name}
./startup.sh
```
4. To update the assignment to check on
```bash
cd ..
./copilot_shell_script.sh
```
When prompted to Enter assignment name : (Go ahead and enter assignment name.)
