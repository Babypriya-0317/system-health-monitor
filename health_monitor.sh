#!/bin/bash

# ---- CONFIGURATION ----
LOG_FILE="/home/babypriyaa/health_monitor/logs/health.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# ---- THRESHOLDS ----
CPU_LIMIT=80
RAM_LIMIT=80
DISK_LIMIT=80

# ---- GET SYSTEM STATS ----
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" |tail -1 | awk '{print $2}' | cut -d'.' -f1)
RAM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# ---- LOG STATS ----
echo "===============================" >> $LOG_FILE
echo "Date: $DATE" >> $LOG_FILE
echo "CPU Usage  : $CPU_USAGE%" >> $LOG_FILE
echo "RAM Usage  : $RAM_USAGE%" >> $LOG_FILE
echo "Disk Usage : $DISK_USAGE%" >> $LOG_FILE

# ---- CHECK CPU ----
if [ "$CPU_USAGE" -gt "$CPU_LIMIT" ]; then
    echo "⚠️  ALERT: CPU usage is HIGH - $CPU_USAGE%" >> $LOG_FILE
fi

# ---- CHECK RAM ----
if [ "$RAM_USAGE" -gt "$RAM_LIMIT" ]; then
    echo "⚠️  ALERT: RAM usage is HIGH - $RAM_USAGE%" >> $LOG_FILE
fi

# ---- CHECK DISK ----
if [ "$DISK_USAGE" -gt "$DISK_LIMIT" ]; then
    echo "⚠️  ALERT: DISK usage is HIGH - $DISK_USAGE%" >> $LOG_FILE
fi

echo "Status: System Checked Successfully" >> $LOG_FILE
