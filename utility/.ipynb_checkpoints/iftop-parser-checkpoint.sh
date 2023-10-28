# Store the list of interface names in a variable
interface_names=$(ip -o link show | awk -F': ' '{print $2}')

# Display the list of interface names (optional)
echo "Interface names: $interface_names"

echo "Select interface"
read interface

echo "Select host (nfs01.ib)"
read host

output_file="dgx_002_$interface.csv"
echo "Output file: $output_file"

# Add column headers to the CSV file
echo "Timestamp,Interface,send,receive" > "$output_file"

# Run iftop in a loop and save data with timestamps
while true
do
    timestamp=$(date +"%H:%M:%S")
    iftop_output=$(iftop -N -t -s 2 -i "$interface" 2>&1)

    if echo "$iftop_output" | grep -q "$host"; then
        #echo "$timestamp: Communication with $host found."

        receive_line=$(echo "$iftop_output" | awk -v host="$host" '$0 ~ host && /<=/')
        receive_value=$(echo "$receive_line" | awk '{print $3}')         # 6 is the cumulative rate. 3 the last2s

        send_line=$(echo "$iftop_output" | awk -v host="$host" -v receive="$receive_line" '$0 ~ host && $0 ~ receive { print prev_line; exit } { prev_line = $0 }')
        send_value=$(echo "$send_line" | awk '{print $4}')

#        echo $send_line
#        echo $send_value
#        echo $iftop_output
    else
     	echo "$timestamp: No communication with $host found."
        send_value=0
        receive_value=0
    fi
    echo "$timestamp,$interface,$send_value,$receive_value" >> "$output_file"

    sleep 1  # Adjust the interval as needed
done
