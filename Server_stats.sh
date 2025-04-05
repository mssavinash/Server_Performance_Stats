#!/bin/bash

# server-stats.sh - Analyze basic server performance statistics

echo "========== SERVER PERFORMANCE STATS =========="

# OS Version
echo -e "\n🖥️ OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2

# Uptime
echo -e "\n⏱️ Uptime:"
uptime -p

# Load Average
echo -e "\n📊 Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

# Logged In Users
echo -e "\n👥 Logged In Users:"
who | wc -l

# CPU Usage
echo -e "\n⚙️ Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{usage = 100 - $8; printf "CPU Usage: %.2f%%\n", usage}'

# Memory Usage
echo -e "\n🧠 Total Memory Usage:"
free -m | awk 'NR==2 {
    used=$3; free=$4; total=$2;
    printf "Used: %d MB, Free: %d MB, Usage: %.2f%%\n", used, free, (used/total)*100
}'

# Disk Usage
echo -e "\n💾 Total Disk Usage (/):"
df -h / | awk 'NR==2 {
    printf "Used: %s, Available: %s, Usage: %s\n", $3, $4, $5
}'

# Top 5 Processes by CPU usage
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory usage
echo -e "\n🧵 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Optional: Failed login attempts (stretch goal)
echo -e "\n❌ Failed Login Attempts:"
journalctl _COMM=sshd | grep "Failed password" | wc -l

echo "=============================================="
