#!/bin/bash -e

# ---- COLORS ----
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ---- CONFIGURATION ----
LOG_FILE="/home/babypriyaa/health_monitor/logs/health.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# ---- THRESHOLDS ----
CPU_LIMIT=80
RAM_LIMIT=80
DISK_LIMIT=80

# ---- GET SYSTEM STATS ----
CPU_USAGE=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{print $2}' | cut -d'.' -f1)
RAM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
NETWORK=$(cat /proc/net/dev | grep -v "lo" | awk 'NR==3 {printf "RX: %d MB | TX: %d MB", $2/1024/1024, $10/1024/1024}')
TOP_PROCESSES=$(ps aux --sort=-%cpu | awk 'NR>=2 && NR<=6 {printf "%-10s %-5s %-5s\n", $11, $3, $4}')

# ---- PRINT TO TERMINAL WITH COLORS ----
echo -e "${BLUE}===============================${NC}"
echo -e "${BLUE}   SYSTEM HEALTH REPORT${NC}"
echo -e "${BLUE}   Date: $DATE${NC}"
echo -e "${BLUE}===============================${NC}"
echo -e "${GREEN}CPU Usage  : $CPU_USAGE%${NC}"
echo -e "${GREEN}RAM Usage  : $RAM_USAGE%${NC}"
echo -e "${GREEN}Disk Usage : $DISK_USAGE%${NC}"
echo -e "${GREEN}Network    : $NETWORK${NC}"
echo -e "${BLUE}===============================${NC}"
echo -e "${YELLOW}Top 5 Processes by CPU:${NC}"
echo -e "${YELLOW}Process    CPU%  MEM%${NC}"
echo -e "$TOP_PROCESSES"
echo -e "${BLUE}===============================${NC}"

# ---- CHECK ALERTS ----
if [ "$CPU_USAGE" -gt "$CPU_LIMIT" ]; then
    echo -e "${RED}⚠️  ALERT: CPU usage is HIGH - $CPU_USAGE%${NC}"
fi
if [ "$RAM_USAGE" -gt "$RAM_LIMIT" ]; then
    echo -e "${RED}⚠️  ALERT: RAM usage is HIGH - $RAM_USAGE%${NC}"
fi
if [ "$DISK_USAGE" -gt "$DISK_LIMIT" ]; then
    echo -e "${RED}⚠️  ALERT: DISK usage is HIGH - $DISK_USAGE%${NC}"
fi

# ---- LOG TO FILE ----
echo "===============================" >> $LOG_FILE
echo "Date: $DATE" >> $LOG_FILE
echo "CPU Usage  : $CPU_USAGE%" >> $LOG_FILE
echo "RAM Usage  : $RAM_USAGE%" >> $LOG_FILE
echo "Disk Usage : $DISK_USAGE%" >> $LOG_FILE
echo "Network    : $NETWORK" >> $LOG_FILE
echo "Top 5 Processes:" >> $LOG_FILE
echo "$TOP_PROCESSES" >> $LOG_FILE
echo "Status: System Checked Successfully" >> $LOG_FILE
echo "===============================" >> $LOG_FILE
