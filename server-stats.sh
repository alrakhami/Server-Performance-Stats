#!/bin/bash

# Function to display total CPU usage
cpu_usage() {
    echo "=== CPU Usage ==="
    # Extracting CPU usage percentage
    uptime | awk -F'load average:' '{ print $2 }' | awk '{ print "Load Average (1, 5, 15 mins):", $1, $2, $3 }'
    echo
}

# Function to display total memory usage
memory_usage() {
    echo "=== Memory Usage ==="
    # Getting total, used and free memory
    free -m | awk 'NR==1{printf "Total Memory: %s MB\n", $2} NR==2{printf "Used Memory: %s MB (%.2f%%)\n", $3, $3*100/$2} NR==3{printf "Free Memory: %s MB (%.2f%%)\n", $4, $4*100/$2}'
    echo
}

# Function to display total disk usage
disk_usage() {
    echo "=== Disk Usage ==="
    # Getting disk usage information
    df -h --total | awk 'END{printf "Total Disk: %s Used: %s (%.2f%%) Free: %s\n", $2, $3, $3*100/$2, $4}'
    echo
}

# Function to display top 5 processes by CPU usage
top_cpu_processes() {
    echo "=== Top 5 Processes by CPU Usage ==="vc
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
}

# Function to display top 5 processes by memory usage
top_memory_processes() {
    echo "=== Top 5 Processes by Memory Usage ==="
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo
}

# Function to display additional stats
additional_stats() {
    echo "=== Additional Stats ==="
    echo "OS Version: $(lsb_release -d | awk -F'\t' '{print $2}')"
    echo "Uptime: $(uptime -p)"
    echo "Logged In Users: $(who | wc -l)"
    echo "Failed Login Attempts: $(grep "Failed password" /var/log/auth.log | wc -l)"
    echo
}

# Main function to call all other functions
main() {
    cpu_usage
    memory_usage
    disk_usage
    top_cpu_processes
    top_memory_processes
    additional_stats
}

# Run the main function
main
