# System Health Monitor

## Description
A bash script that monitors system health by checking 
CPU, RAM, and Disk usage with automated alerts and logging.

## Features
- Real time CPU usage monitoring
- RAM usage monitoring
- Disk usage monitoring
- Alert system when usage crosses 80% threshold
- Activity logging with timestamp
- Automated scheduling using cron

## Technologies Used
- Linux (Ubuntu)
- Bash Scripting
- top, free, df commands
- cron

## Project Structure
health_monitor/
├── health_monitor.sh   # Main monitoring script
├── README.md           # Project documentation
└── logs/               # Log files

## How to Run
# Clone the repo
git clone https://github.com/Babypriya-0317/system-health-monitor

# Give permission
chmod +x health_monitor.sh

# Run the script
./health_monitor.sh

## Automate With Cron
# Open crontab
crontab -e

# Add this line to run every 5 minutes
*/5 * * * * /home/username/health_monitor/health_monitor.sh

## Sample Output
===============================
Date: 2026-06-14_09-34-00
CPU Usage  : 1%
RAM Usage  : 29%
Disk Usage : 1%
Status: System Checked Successfully
===============================
