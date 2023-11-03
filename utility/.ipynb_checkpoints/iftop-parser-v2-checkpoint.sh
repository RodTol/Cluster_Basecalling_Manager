#!/usr/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

echo "Select interface"
interface=$1
echo interface

echo "Select host (nfs01.ib)"
host=$2
echo host

output_file=/AB_20T_output/nanopore_output/run_logs/$3/connection_log_$3.csv
echo "Output file: $output_file"

# Add column headers to the CSV file
echo "Timestamp;Interface;send;receive" > "$output_file"

# Run iftop in a loop and save data with timestamps
while true
do
    timestamp=$(date +"%H:%M:%S")
    iftop_output=$(iftop -N -t -s 1 -i "$interface" 2>&1)

    if echo "$iftop_output" | grep -q "$host"; then
        echo -e "$timestamp: ${GREEN}Communication with $host found.${RESET}"

        receive_line=$(echo "$iftop_output" | awk -v host="$host" '$0 ~ host && /<=/')
        receive_value=$(echo "$receive_line" | awk '{print $3}')         # 6 is the cumulative rate. 3 the last2s

        send_line=$(echo "$iftop_output" | awk -v host="$host" -v receive="$receive_line" '$0 ~ host && $0 ~ receive { print prev_line; exit } { prev_line = $0 }')
        send_value=$(echo "$send_line" | awk '{print $4}')

#        echo $send_line
#        echo $send_value
#        echo $iftop_output
    else
     	echo -e "$timestamp:  ${RED}No communication with $host found.${RESET}"
        send_value=0
        receive_value=0
    fi
    echo "$timestamp;$interface;$send_value;$receive_value" >> "$output_file"

    sleep 1  # Adjust the interval as needed
done
